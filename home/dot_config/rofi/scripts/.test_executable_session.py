import sys
from io import StringIO

import pytest
from executable_session import write_mode, write_row


@pytest.fixture
def capture_output(monkeypatch):
    """Capture stdout output."""
    output = StringIO()
    monkeypatch.setattr(sys, "stdout", output)
    return output


def test_write_row_multiple_options(capture_output):
    """Test write_row with multiple options."""
    write_row(
        "Shutdown",
        "Power Off",
        icon="system-shutdown",
        info="systemctl poweroff",
        meta="off",
    )
    output = capture_output.getvalue()
    assert "icon" in output
    assert "info" in output
    assert "meta" in output

    def test_write_mode_basic(capture_output):
        """Test basic write_mode output format."""
        write_mode("prompt", " 󰍂 ")
        output = capture_output.getvalue()
        assert output == "\0prompt\x1f 󰍂 \n"

    def test_write_mode_null_separator(capture_output):
        """Test that write_mode starts with null byte."""
        write_mode("message", "Session Control")
        output = capture_output.getvalue()
        assert output[0] == "\0"

    def test_write_mode_file_separator(capture_output):
        """Test that write_mode uses file separator between option and value."""
        write_mode("theme", "window {width: 400px;}")
        output = capture_output.getvalue()
        assert "\x1f" in output
        parts = output.rstrip("\n").split("\x1f")
        assert len(parts) == 2
        assert parts[0] == "\0theme"
        assert parts[1] == "window {width: 400px;}"

    def test_write_mode_various_options(capture_output):
        """Test write_mode with different mode options."""
        write_mode("markup-rows", "true")
        output = capture_output.getvalue()
        assert "markup-rows" in output
        assert "true" in output

    def test_write_mode_empty_value(capture_output):
        """Test write_mode with empty value."""
        write_mode("delim", "")
        output = capture_output.getvalue()
        assert output == "\0delim\x1f\n"


def test_write_row_basic(capture_output):
    """Test basic write_row with label and subtext."""
    write_row("Lock", "Hyprlock")
    output = capture_output.getvalue()
    assert "Lock" in output
    assert "Hyprlock" in output
    assert "<span foreground='gray' size='small'><i>Hyprlock</i></span>" in output


def test_write_row_with_options(capture_output):
    """Test write_row with additional options."""
    write_row("Suspend", "Sleep", icon="system-suspend", info="systemctl suspend")
    output = capture_output.getvalue()
    assert "Suspend" in output
    assert "icon" in output
    assert "system-suspend" in output
    assert "info" in output
    assert "systemctl suspend" in output


def test_write_row_no_subtext(capture_output):
    """Test write_row without subtext."""
    write_row("Reboot")
    output = capture_output.getvalue()
    assert "Reboot" in output
    assert "<span foreground='gray' size='small'><i></i></span>" in output


def test_write_row_null_separator(capture_output):
    """Test that output starts with null byte separator."""
    write_row("Test", "subtext", key="value")
    output = capture_output.getvalue()
    assert output[0] == "\0"
