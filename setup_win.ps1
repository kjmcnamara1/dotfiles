
$dotfiles = Get-Location
$folder='nushell'
$target = [io.path]::Combine($dotfiles,'.config', $folder)
# $link = [io.path]::Combine($env:USERPROFILE,'.config', $folder)
$link = [io.path]::Combine($env:APPDATA, $folder)

Write-Output $target
Write-Output $link

New-Item -Path $link -ItemType SymbolicLink -Value $target