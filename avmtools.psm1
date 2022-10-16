(Get-ChildItem -Path "$PSScriptRoot\functions" -Recurse -Filter *.ps1) | ForEach-Object {
    . $_.FullName
}