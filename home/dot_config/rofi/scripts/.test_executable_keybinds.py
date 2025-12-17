import json
from enum import show_flag_values
from unittest.mock import patch

import pytest
from executable_keybinds import (
    Keybind,
    Mod,
    create_keystring,
    extract_submaps,
    filter_bind_fields,
    generate_keybinds,
    get_raw_binds,
)


def _expected(mod_instance: Mod, reverse: bool = True, sep: str = " + ") -> str:
    parts = [Mod(m).name or "UNKNOWN" for m in show_flag_values(mod_instance)]
    if reverse:
        parts.reverse()
    return sep.join(parts)


def test_single_modifier_default():
    assert Mod.SHIFT.format() == "SHIFT"


def test_combined_modifiers_default_reverse():
    combo = Mod.SHIFT | Mod.CTRL
    assert combo.format() == _expected(combo)


def test_combined_modifiers_no_reverse_custom_sep():
    combo = Mod.SUPER | Mod.ALT | Mod.CTRL
    assert combo.format(reverse=False, sep="-") == _expected(
        combo, reverse=False, sep="-"
    )


def test_unknown_modifier_shows_unknown():
    # value 2 is not defined in Mod; should yield "UNKNOWN"
    unknown_mod = Mod(2)
    result = unknown_mod.format()
    assert result == "UNKNOWN"


def test_get_raw_binds_success():
    mock_data = [{"key": "Super_L", "dispatcher": "exec", "arg": "rofi -show drun"}]
    with patch("subprocess.check_output", return_value=json.dumps(mock_data).encode()):
        result = get_raw_binds()
        assert result == mock_data


def test_get_raw_binds_empty_list():
    with patch("subprocess.check_output", return_value=b"[]"):
        result = get_raw_binds()
        assert result == []


def test_get_raw_binds_exception_returns_empty():
    with patch("subprocess.check_output", side_effect=Exception("hyprctl not found")):
        result = get_raw_binds()
        assert result == []


def test_get_raw_binds_json_decode_error(capsys):
    with patch("subprocess.check_output", return_value=b"invalid json"):
        result = get_raw_binds()
        assert result == []
        captured = capsys.readouterr()
        assert "Warning: Failed to get bind list due to:" in captured.out


def test_filter_bind_fields_basic():
    binds = [{"a": 1, "b": 2}, {"a": 3, "c": 4}]
    fields = ["a", "b"]
    expected = [{"a": 1, "b": 2}, {"a": 3}]
    assert filter_bind_fields(binds, fields) == expected


def test_filter_bind_fields_empty_fields_returns_empty_dicts():
    binds = [{"x": 10}, {"y": 20}]
    fields = []
    expected = [{}, {}]
    assert filter_bind_fields(binds, fields) == expected


def test_filter_bind_fields_empty_binds_returns_empty_list():
    binds = []
    fields = ["a", "b"]
    assert filter_bind_fields(binds, fields) == []


def test_filter_bind_fields_does_not_mutate_input():
    binds = [{"k": 1, "keep": True}, {"k": 2}]
    original = [b.copy() for b in binds]
    _ = filter_bind_fields(binds, ["k"])
    assert binds == original


def test_generate_keybinds_basic():
    raw = [
        {
            "submap": "",
            "modmask": Mod.CTRL.value,
            "key": "A",
            "description": "Test",
            "dispatcher": "exec",
            "arg": "echo test",
        }
    ]
    result = generate_keybinds(raw)
    assert len(result) == 1
    kb = result[0]
    assert isinstance(kb, Keybind)
    assert kb.submap == ""
    assert kb.modmask == Mod.CTRL
    assert kb.key == "A"
    assert kb.description == "Test"
    assert kb.dispatcher == "exec"
    assert kb.arg == "echo test"


def test_generate_keybinds_missing_fields():
    raw = [
        {
            "modmask": Mod.ALT.value,
            "key": "B",
            "description": "Desc",
            "dispatcher": "exec",
            "arg": "cmd",
        }
    ]
    result = generate_keybinds(raw)
    assert len(result) == 1
    kb = result[0]
    assert kb.submap == ""


def test_generate_keybinds_multiple_entries():
    raw = [
        {
            "submap": "",
            "modmask": Mod.SHIFT.value,
            "key": "C",
            "description": "First",
            "dispatcher": "exec",
            "arg": "cmd1",
        },
        {
            "submap": "sub",
            "modmask": Mod.SUPER.value,
            "key": "D",
            "description": "Second",
            "dispatcher": "submap",
            "arg": "reset",
        },
    ]
    result = generate_keybinds(raw)
    assert len(result) == 2
    assert result[0].key == "C"
    assert result[1].key == "D"


def test_generate_keybinds_empty_input():
    assert generate_keybinds([]) == []


def test_generate_keybinds_handles_nonexistent_fields():
    raw = [
        {
            "submap": "",
            "modmask": Mod.CTRL.value,
            "key": "E",
            "description": "Extra",
            "dispatcher": "exec",
            "arg": "cmd2",
            "extra_field": "should be ignored",
        }
    ]
    result = generate_keybinds(raw)
    assert len(result) == 1
    kb = result[0]
    assert not hasattr(kb, "extra_field")


def test_extract_submaps_basic():
    kb1 = Keybind(
        submap="",
        modmask=Mod.CTRL,
        key="A",
        description="Desc1",
        dispatcher="submap",
        arg="submap1",
    )
    kb2 = Keybind(
        submap="",
        modmask=Mod.ALT,
        key="B",
        description="Desc2",
        dispatcher="exec",
        arg="cmd",
    )
    kb3 = Keybind(
        submap="",
        modmask=Mod.SHIFT,
        key="C",
        description="Desc3",
        dispatcher="submap",
        arg="submap2",
    )
    binds = [kb1, kb2, kb3]
    result = extract_submaps(binds)
    assert isinstance(result, dict)
    assert set(result.keys()) == {"submap1", "submap2"}
    assert result["submap1"] is kb1
    assert result["submap2"] is kb3


def test_extract_submaps_filters_non_submap():
    kb_exec = Keybind(
        submap="",
        modmask=Mod.CTRL,
        key="A",
        description="Desc",
        dispatcher="exec",
        arg="cmd",
    )
    result = extract_submaps([kb_exec])
    assert result == {}


def test_extract_submaps_excludes_reset():
    kb_reset = Keybind(
        submap="",
        modmask=Mod.CTRL,
        key="A",
        description="Desc",
        dispatcher="submap",
        arg="reset",
    )
    result = extract_submaps([kb_reset])
    assert result == {}


def test_extract_submaps_empty_input():
    assert extract_submaps([]) == {}


def test_extract_submaps_duplicate_args():
    kb1 = Keybind(
        submap="",
        modmask=Mod.CTRL,
        key="A",
        description="Desc1",
        dispatcher="submap",
        arg="submap",
    )
    kb2 = Keybind(
        submap="",
        modmask=Mod.ALT,
        key="B",
        description="Desc2",
        dispatcher="submap",
        arg="submap",
    )
    result = extract_submaps([kb1, kb2])
    # Last one wins in dict comprehension
    assert result["submap"] is kb2


def test_create_keystring_basic_no_mod_no_submap():
    kb = Keybind(
        submap="",
        modmask=Mod(0),
        key="A",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {}
    result = create_keystring(kb, submaps)
    assert result == "A"


def test_create_keystring_with_modifiers():
    kb = Keybind(
        submap="",
        modmask=Mod.CTRL | Mod.SHIFT,
        key="B",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {}
    expected = f"{Mod.CTRL.format()} + {Mod.SHIFT.format()} + B"
    # But format() reverses by default, so:
    expected = "SHIFT + CTRL + B"
    result = create_keystring(kb, submaps)
    assert result == expected


def test_create_keystring_with_submap_prefix():
    submap_kb = Keybind(
        submap="",
        modmask=Mod.ALT,
        key="X",
        description="submap desc",
        dispatcher="submap",
        arg="mysubmap",
    )
    kb = Keybind(
        submap="mysubmap",
        modmask=Mod.CTRL,
        key="Y",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {"mysubmap": submap_kb}
    result = create_keystring(kb, submaps)
    # submap prefix: ALT + X, then CTRL + Y
    assert result.startswith("ALT + X")
    assert result.endswith("CTRL + Y")


def test_create_keystring_with_is_submap_appends_separator():
    kb = Keybind(
        submap="",
        modmask=Mod.SHIFT,
        key="Z",
        description="desc",
        dispatcher="submap",
        arg="mysubmap",
    )
    submaps = {}
    result = create_keystring(kb, submaps)
    assert result.endswith(", ")


def test_create_keystring_nested_submaps():
    kb_sub2 = Keybind(
        submap="",
        modmask=Mod.ALT,
        key="B",
        description="desc",
        dispatcher="submap",
        arg="sub2",
    )
    kb_sub1 = Keybind(
        submap="sub2",
        modmask=Mod.CTRL,
        key="A",
        description="desc",
        dispatcher="submap",
        arg="sub1",
    )
    kb_main = Keybind(
        submap="sub1",
        modmask=Mod.SHIFT,
        key="C",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {"sub1": kb_sub1, "sub2": kb_sub2}
    result = create_keystring(kb_main, submaps)
    # Should include all three keystrings in order
    assert "ALT + B" in result
    assert "CTRL + A" in result
    assert "SHIFT + C" in result


def test_create_keystring_custom_separators():
    kb = Keybind(
        submap="",
        modmask=Mod.CTRL | Mod.ALT,
        key="D",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {}
    result = create_keystring(
        kb,
        submaps,
        sm_sep=" <submap> ",
        key_sep=" -> ",
        mod_sep=" & ",
        mod_reverse=False,
    )
    # Should use custom separators
    assert "CTRL & ALT" in result
    assert " -> D" in result


def test_create_keystring_submap_missing_in_dict_raises_keyerror():
    kb = Keybind(
        submap="missing_submap",
        modmask=Mod.CTRL,
        key="E",
        description="desc",
        dispatcher="exec",
        arg="cmd",
    )
    submaps = {}
    with pytest.raises(KeyError):
        create_keystring(kb, submaps)
