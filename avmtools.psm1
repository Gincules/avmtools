# source required classes for all PowerShell versions
ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Classes\Generic" -Recurse -Filter *.ps1)) {
    . $object.FullName
}

# source required enums for all PowerShell versions
ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Enums\Generic" -Recurse -Filter *.ps1)) {
    . $object.FullName
}

# since Invoke-RestMethod has different parameters between Windows PowerShell 5.1 and PowerShell Core 7.2, relevant functions being sourced
if ($PSVersionTable.PSVersion.Major -gt 5) {
    <#
    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Classes\PSVersion7" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
    #>

    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion7" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
} else {
    <#
    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Classes\PSVersion5" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
    #>

    ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\PSVersion5" -Recurse -Filter *.ps1)) {
        . $object.FullName
    }
}

# source required functions for all PowerShell versions
ForEach ($object in (Get-ChildItem -Path "$PSScriptRoot\Functions\Generic" -Recurse -Filter *.ps1)) {
    . $object.FullName
}