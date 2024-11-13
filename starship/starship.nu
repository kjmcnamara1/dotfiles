# this file is both a valid
# - overlay which can be loaded with `overlay use starship.nu`
# - module which can be used with `use starship.nu`
# - script which can be used with `source starship.nu`
export-env { 
    def indicator-prompt [mode:string=insert] {
        let palette = {
            black: "#2E3440"
            bright-black: "#4C566A"
            red: "#BF616A"
            green: "#A3BE8C"
            yellow: "#EBCB8B"
            blue: "#5E81AC"
            purple: "#B48EAD"
            cyan: "#88C0D0"
            white: "#e5e9f0"
            bright-white: "#ECEFF4"
            light: "#D8DEE9"
            bright-cyan: "#8FBCBB"
            frost: "#81A1C1"
            orange: "#D08770"
        }

    # with-env {STARSHIP_SHELL: fish} {
            # $env.STARSHIP_SHELL
            # starship module --status $env.LAST_EXIT_CODE --keymap $mode character
        # 
        let characters = {
            insert:" ❯ "
            normal:" ❮ "
            completion:"  "
            help:" 󰋖 "
            history:"  "
        }
        let character = $characters | get $mode
        let format = if ( $env.LAST_EXIT_CODE | into bool ) {
            ansi $palette.red
        } else {
            ansi $palette.green
        }

        $"(ansi reset)($format)($character)(ansi reset)"
    }

    load-env {
        STARSHIP_SHELL: "nu"
        STARSHIP_SESSION_KEY: (random chars -l 16)
        VIRTUAL_ENV_DISABLE_PROMPT: true
        PROMPT_MULTILINE_INDICATOR: (
            ^/usr/sbin/starship prompt --continuation
        )

        # Does not play well with default character module.
        # TODO: Also Use starship vi mode indicators?
        PROMPT_INDICATOR: {|| indicator-prompt insert }
        PROMPT_INDICATOR_VI_INSERT: { || indicator-prompt insert }
        PROMPT_INDICATOR_VI_NORMAL: { || indicator-prompt normal }
        TRANSIENT_PROMPT_INDICATOR: ''
        TRANSIENT_PROMPT_INDICATOR_VI_INSERT: ''
        TRANSIENT_PROMPT_INDICATOR_VI_NORMAL: ''

        PROMPT_COMMAND: {||
            # jobs are not supported
            (
                ^/usr/sbin/starship prompt
                    --cmd-duration $env.CMD_DURATION_MS
                    $"--status=($env.LAST_EXIT_CODE)"
                    --terminal-width (term size).columns
                | str replace (starship module --status $env.LAST_EXIT_CODE character) ''
            )
        }

        PROMPT_COMMAND_RIGHT: {||
            (
                ^/usr/sbin/starship prompt
                    --right
                    --cmd-duration $env.CMD_DURATION_MS
                    $"--status=($env.LAST_EXIT_CODE)"
                    --terminal-width (term size).columns
            )
        }

        TRANSIENT_PROMPT_COMMAND: {||
            with-env {STARSHIP_CONFIG: $"($env.HOME)/.config/starship/starship_transient.toml"} {
                starship prompt --cmd-duration $env.CMD_DURATION_MS --status $env.LAST_EXIT_CODE --terminal-width (term size).columns
            }
        }

        TRANSIENT_PROMPT_COMMAND_RIGHT: {||
            with-env {STARSHIP_CONFIG: $"($env.HOME)/.config/starship/starship_transient.toml"} {
                starship prompt --right --cmd-duration $env.CMD_DURATION_MS --status $env.LAST_EXIT_CODE --terminal-width (term size).columns
            }
        }
        
        config: ($env.config? | default {} | merge {
            render_right_prompt_on_last_line: true
        menus: [
            {
                name: completion_menu
                only_buffer_difference: false
                marker: ( indicator-prompt completion )
                type: {
                    layout: columnar
                    page_size: 10
                }
                style: {
                    text: '#4C566A'
                    selected_text: '#EBCB8B'
                    description_text: '#81A1C1'
                }
            }
            {
                name: history_menu
                only_buffer_difference: false
                marker: ( indicator-prompt history )
                type: {
                    layout: list
                    page_size: 10
                }
                style: {
                    text: '#4C566A'
                    selected_text: '#EBCB8B'
                    description_text: '#81A1C1'
                }
            }
            {
                name: help_menu
                only_buffer_difference: false
                marker: ( indicator-prompt help )
                type: {
                    layout: description
                    columns: 4
                    col_padding: 2
                    selection_rows: 4
                    description_rows: 10
                }
                style: {
                    text: '#4C566A'
                    selected_text: '#EBCB8B'
                    description_text: '#81A1C1'
                }
            }
        ]
        })

}
}
