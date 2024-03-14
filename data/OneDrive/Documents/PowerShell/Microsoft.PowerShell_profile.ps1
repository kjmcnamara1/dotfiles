function Invoke-Starship-TransientFunction {
  # $env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\starship_transient.toml"
  &starship module character
  # Remove-Item Env:\STARSHIP_CONFIG
  # $env:STARSHIP_CONFIG = $null
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt
