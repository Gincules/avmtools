$psMajor = $PSVersionTable.PSVersion.Major
$psMinor = $PSVersionTable.PSVersion.Minor

if (( $psMajor -ge 7) -And ($psMinor -ge 2)) {
    (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion7" -Recurse -Filter *.ps1) | ForEach-Object {
        . $_.FullName
    }
} else {
    (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion5" -Recurse -Filter *.ps1) | ForEach-Object {
        . $_.FullName
    }
}


(Get-ChildItem -Path "$PSScriptRoot\Functions\Generic" -Recurse -Filter *.ps1) | ForEach-Object {
    . $_.FullName
}