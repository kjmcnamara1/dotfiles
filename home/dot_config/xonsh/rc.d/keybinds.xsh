from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import ViInsertMode, EmacsInsertMode
# from xonsh.events import events


# @events.on_ptk_create
# def _custom_keybindings(bindings, **kw):
#     insert_mode = ViInsertMode() | EmacsInsertMode()
    
    # print(*bindings.bindings,sep="\n")

#     @bindings.add("escape", "h", filter=insert_mode)
#     def _(event):
#         event.current_buffer.cursor_left()

#     @bindings.add("escape", "j", filter=insert_mode)
#     def _(event):
#         event.current_buffer.cursor_down()

#     @bindings.add("escape", "k", filter=insert_mode)
#     def _(event):
#         event.current_buffer.cursor_up()

#     @bindings.add("escape", "l", filter=insert_mode)
#     def _(event):
#         event.current_buffer.cursor_right()
