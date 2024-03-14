function Invoke-Starship-TransientFunction {
  # $env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\starship_transient.toml"
  &starship module character
  # Remove-Item Env:\STARSHIP_CONFIG
  # $env:STARSHIP_CONFIG = $null
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt

function Grid-List {eza --icons -F -H --group-directories-first --git}
Set-Alias l Grid-List

function Column-List {eza --icons -F -H --group-directories-first --git -1}
Set-Alias ls Column-List

function All-List {eza --icons -F -H --group-directories-first --git -1A}
Set-Alias la All-List

function Long-List {eza --icons -F -H --group-directories-first --git -1Al}
Set-Alias ll Long-List
