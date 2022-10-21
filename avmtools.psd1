#
# Module manifest for module 'avmtools'
#
# Generated by: Gincules
#
# Generated on: 01.02.2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'avmtools.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '4e54b9be-b9bd-4999-9a0c-8019832ff93c'

# Author of this module
Author = 'Gincules'

# Company or vendor of this module
CompanyName = ''

# Copyright statement for this module
Copyright = '(c) Gincules. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Query and configure a FRITZ!Box using TR-064 protocol'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Connect-AvmDevice',
    'Invoke-AvmAction',
    'Get-AvmAppConfig',
    'Get-AvmAppInfo',
    'Get-AvmAppRemoteInfo',
    'Get-AvmAuthInfo',
    'Get-AvmAuthState',
    'Get-AvmDectNumberOfEntry',
    'Get-AvmDevicePersistentData',
    'Get-AvmDeviceSupportDataInfo',
    'Get-AvmDeviceUuid',
    'Get-AvmDeviceInfo',
    'Get-AvmDeviceLog',
    'Get-AvmDeviceSecurityPort',
    'Get-AvmFilelinksNumberOfEntry',
    'Get-AvmFilelinskPath',
    'Get-AvmHomeautoInfo',
    'Get-AvmHomeplugNumberOfEntry',
    'Get-AvmHostFilterMarkTicket',
    'Get-AvmHostChangeCounter',
    'Get-AvmHostListPath',
    'Get-AvmHostMeshListPath',
    'Get-AvmLanAnonymousLogin',
    'Get-AvmLanConfigSecurityInfo',
    'Get-AvmLanCurrentUser',
    'Get-AvmLanUserList',
    'Get-AvmLanEthernetInterfaceConfigInfo',
    'Get-AvmLanStatistic',
    'Get-AvmLanAddressRange',
    'Get-AvmLanEntry',
    'Get-AvmLanHostConfigManagementInfo',
    'Get-AvmLanRouterList',
    'Get-AvmLanSubnetMask',
    'Get-AvmLayer3ForwardingDefaultConnectionService',
    'Get-AvmLayer3ForwardingNumberOfEntry',
    'Get-AvmManagementServerInfo',
    'Get-AvmMyFritzInfo',
    'Get-AvmMyFritzNumberOfService',
    'Get-AvmOnTelCallBarringList',
    'Get-AvmOnTelCallList',
    'Get-AvmOnTelDectHandsetInfo',
    'Get-AvmOnTelDeflection',
    'Get-AvmOnTelNumberOfDeflection',
    'Get-AvmOnTelNumberOfEntry',
    'Get-AvmOnTelPhonebookList',
    'Get-AvmRemoteAccessDdnsInfo',
    'Get-AvmRemoteAccessDdnsProvider',
    'Get-AvmRemoteAccessInfo',
    'Get-AvmSpeedtestInfo',
    'Get-AvmStorageInfo',
    'Get-AvmStorageUserInfo',
    'Get-AvmTamList',
    'Get-AvmTimeInfo',
    'Get-AvmUpnpInfo',
    'Get-AvmUserInterfaceInfo',
    'Get-AvmUserInterfaceInternationalConfig',
    'Get-AvmUserInterfaceUpdateInfo',
    'Get-AvmVoipAlarmClocks',
    'Get-AvmVoipAreaCode',
    'Get-AvmVoipClient',
    'Get-AvmVoipCommonCountryCode',
    'Get-AvmVoipCountryCode',
    'Get-AvmVoipDialConfig',
    'Get-AvmVoipExistingNumber',
    'Get-AvmVoipExtendedInfo',
    'Get-AvmVoipInfo',
    'Get-AvmVoipMaxNumber',
    'Get-AvmVoipNumber',
    'Get-AvmVoipNumberOfClient',
    'Get-AvmVoipNumberOfNumber',
    'Get-AvmWanLinkProperty',
    'Get-AvmWanTotalByteReceived',
    'Get-AvmWanTotalByteSent',
    'Get-AvmWanTotalPacketReceived',
    'Get-AvmWanTotalPacketSent',
    'Get-AvmWanEthernetLinkStatus',
    'Get-AvmWanDnsServer',
    'Get-AvmWanExternalAddress',
    'Get-AvmWanIpConnectionInfo',
    'Get-AvmWanNatRsipStatus',
    'Get-AvmWanPortMappingEntry',
    'Get-AvmWanStatusInfo',
    'Get-AvmWanTypeInfo',
    'Get-AvmWebDavClientInfo',
    'Get-AvmWlanBeaconAdvertisement',
    'Get-AvmWlanBeaconType',
    'Get-AvmWlanBssid',
    'Get-AvmWlanChannelInfo',
    'Get-AvmWlanConfigurationInfo',
    'Get-AvmWlanDeviceListPath',
    'Get-AvmWlanExternalInfo',
    'Get-AvmWlanHybridMode',
    'Get-AvmWlanIptvOptimized',
    'Get-AvmWlanNightControl',
    'Get-AvmWlanPacketStatistic',
    'Get-AvmWlanSecruityProperty',
    'Get-AvmWlanSecurityKey',
    'Get-AvmWlanSsid',
    'Get-AvmWlanStatistic',
    'Get-AvmWlanTotalAssociation',
    'Get-AvmWlanWpsInfo',
    'Get-AvmAppMessageFilter',
    'Restart-AvmDevice',
    'Reset-AvmDevice',
    'Register-AvmApp',
    'Reset-AvmEvent',
    'Set-AvmAppMessageFilter',
    'Set-AvmAppVpn',
    'Get-AvmGenericDectEntry',
    'Set-AvmDevicePersistentData',
    'Set-AvmHomeautoDeviceName'
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('avm', 'avmtools', 'fritzbox', 'fritz', 'api')

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/Gincules/avmtools/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Gincules/avmtools'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}