ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Classes\Generic" -Recurse -Filter *.ps1)) {
    . $object.FullName
}

if ($PSVersionTable.PSVersion.Major -gt 5) {
    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion7" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
} else {
    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion5" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
}

ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\Generic" -Recurse -Filter *.ps1)) {
    . $object.FullName
}