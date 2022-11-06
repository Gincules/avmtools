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
ModuleVersion = '1.319.21'

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
    'Add-AvmLayer3ForwardingEntry',
    'Add-AvmVoipAccount',
    'Add-AvmWanPortMapping',
    'Add-AvmWanPppConnectionPortMapping',
    'Connect-AvmDevice',
    'Deny-AvmHostFilterWanAccessByIp',
    'Enable-AvmLanDhcpServer',
    'Enable-AvmManagement',
    'Enable-AvmManagementServerFirmwareDownload',
    'Enable-AvmOnTel',
    'Enable-AvmOnTelByIndex',
    'Enable-AvmOnTelConfigByIndex',
    'Enable-AvmOnTelDeflection',
    'Enable-AvmRemoteAccess',
    'Enable-AvmTam',
    'Find-AvmHostUpdate',
    'Find-AvmUserInterfaceUpdate',
    'Get-AvmAppConfig',
    'Get-AvmAppInfo',
    'Get-AvmAppMessageFilter',
    'Get-AvmAppRemoteInfo',
    'Get-AvmAuthInfo',
    'Get-AvmAuthState',
    'Get-AvmDectNumberOfEntry',
    'Get-AvmDeviceConfigFile',
    'Get-AvmDeviceConfigurationFinished',
    'Get-AvmDeviceInfo',
    'Get-AvmDeviceLog',
    'Get-AvmDevicePersistentData',
    'Get-AvmDeviceSecurityPort',
    'Get-AvmDeviceSupportDataInfo',
    'Get-AvmDeviceUuid',
    'Get-AvmFilelinkNumberOfEntry',
    'Get-AvmFilelinkListPath',
    'Get-AvmGenericDectEntry',
    'Get-AvmGenericFilelinkEntry',
    'Get-AvmHomeautoGenericDeviceInfo',
    'Get-AvmHomeautoInfo',
    'Get-AvmHomeautoSpecificDeviceInfo',
    'Get-AvmHomeplugGenericDeviceEntry',
    'Get-AvmHomeplugNumberOfEntry',
    'Get-AvmHomeplugSpecificDevicEntry',
    'Get-AvmHostAutoWakeOnLanByMac',
    'Get-AvmHostChangeCounter',
    'Get-AvmHostFilterTicketIdStatus',
    'Get-AvmHostFilterWanAccessByIp',
    'Get-AvmHostGenericHostEntry',
    'Get-AvmHostListPath',
    'Get-AvmHostMeshListPath',
    'Get-AvmHostNumberOfEntry',
    'Get-AvmHostSpecificHostEntry',
    'Get-AvmLanAddressRange',
    'Get-AvmLanAnonymousLogin',
    'Get-AvmLanConfigSecurityInfo',
    'Get-AvmLanCurrentUser',
    'Get-AvmLanEntry',
    'Get-AvmLanEthernetInterfaceConfigInfo',
    'Get-AvmLanHostConfigManagementInfo',
    'Get-AvmLanRouterList',
    'Get-AvmLanStatistic',
    'Get-AvmLanSubnetMask',
    'Get-AvmLanUserList',
    'Get-AvmLayer3ForwardingDefaultConnectionService',
    'Get-AvmLayer3ForwardingGenericEntry',
    'Get-AvmLayer3ForwardingNumberOfEntry',
    'Get-AvmLayer3ForwardingSpecificForwardingEntry',
    'Get-AvmManagementServerFirmwareDownload',
    'Get-AvmManagementServerInfo',
    'Get-AvmMyFritzInfo',
    'Get-AvmMyFritzNumberOfService',
    'Get-AvmMyFritzServiceByInfo',
    'Get-AvmOnCallBarringEntry',
    'Get-AvmOnTelBarringEntryByNum',
    'Get-AvmOnTelCallBarringList',
    'Get-AvmOnTelCallList',
    'Get-AvmOnTelDectHandsetInfo',
    'Get-AvmOnTelDectHandsetList',
    'Get-AvmOnTelDeflection',
    'Get-AvmOnTelDeflectionById',
    'Get-AvmOnTelInfoByIndex',
    'Get-AvmOnTelNumberOfDeflection',
    'Get-AvmOnTelNumberOfEntry',
    'Get-AvmOnTelPhonebookEntry',
    'Get-AvmOnTelPhonebookEntryUid',
    'Get-AvmOnTelPhonebookList',
    'Get-AvmOnTelPhonelist',
    'Get-AvmRemoteAccessDdnsInfo',
    'Get-AvmRemoteAccessDdnsProvider',
    'Get-AvmRemoteAccessInfo',
    'Get-AvmSpecificDectEntry',
    'Get-AvmSpecificFilelinkEntry',
    'Get-AvmSpecificHostEntryByIp',
    'Get-AvmSpeedtestInfo',
    'Get-AvmStorageInfo',
    'Get-AvmStorageUserInfo',
    'Get-AvmTamInfo',
    'Get-AvmTamList',
    'Get-AvmTamMessageList',
    'Get-AvmTimeInfo',
    'Get-AvmUpnpInfo',
    'Get-AvmUserInterfaceInfo',
    'Get-AvmUserInterfaceInternationalConfig',
    'Get-AvmUserInterfaceUpdateInfo',
    'Get-AvmVoipAccount',
    'Get-AvmVoipAlarmClock',
    'Get-AvmVoipClient',
    'Get-AvmVoipClient2',
    'Get-AvmVoipClient3',
    'Get-AvmVoipClientByIp',
    'Get-AvmVoipClients',
    'Get-AvmVoipCommonAreaCode',
    'Get-AvmVoipCommonCountryCode',
    'Get-AvmVoipDialConfig',
    'Get-AvmVoipEnableAreaCode',
    'Get-AvmVoipEnableCountryCode',
    'Get-AvmVoipExistingNumbers',
    'Get-AvmVoipInfo',
    'Get-AvmVoipInfoEx',
    'Get-AvmVoipMaxNumber',
    'Get-AvmVoipNumber',
    'Get-AvmVoipNumberOfAlarmClock',
    'Get-AvmVoipNumberOfClient',
    'Get-AvmVoipNumberOfNumber',
    'Get-AvmVoipPhonePort',
    'Get-AvmWanDnsServer',
    'Get-AvmWanDslInterfaceConfigDiagnoseInfo',
    'Get-AvmWanDslInterfaceConfigDslInfo',
    'Get-AvmWanDslInterfaceConfigInfo',
    'Get-AvmWanDslInterfaceConfigTotalStatistic',
    'Get-AvmWanDslLinkAutoConfig',
    'Get-AvmWanDslLinkConfigAtmEncapsulation',
    'Get-AvmWanDslLinkConfigDestinationAddress',
    'Get-AvmWanDslLinkConfigInfo',
    'Get-AvmWanDslLinkConfigLinkInfo',
    'Get-AvmWanDslLinkConfigStatistic',
    'Get-AvmWanEthernetLinkStatus',
    'Get-AvmWanExternalAddress',
    'Get-AvmWanGenericPortMappingEntry',
    'Get-AvmWanInfo',
    'Get-AvmWanIpConnectionInfo',
    'Get-AvmWanLinkProperty',
    'Get-AvmWanNatRsipStatus',
    'Get-AvmWanOnlineMonitor',
    'Get-AvmWanPortMappingEntry',
    'Get-AvmWanPppConnectionDnsServer',
    'Get-AvmWanPppConnectionExternalIpAddress',
    'Get-AvmWanPppConnectionGenericPortMappingEntry',
    'Get-AvmWanPppConnectionInfo',
    'Get-AvmWanPppConnectionLinkLayerMaxBitRate',
    'Get-AvmWanPppConnectionNatRsipStatus',
    'Get-AvmWanPppConnectionSpecificPortMappingEntry',
    'Get-AvmWanPppConnectionStatusInfo',
    'Get-AvmWanPppConnectionTypeInfo',
    'Get-AvmWanPppConnectionUserName',
    'Get-AvmWanPppConnectoinAutoDisconnectTimeSpan',
    'Get-AvmWanPppConnectonPortMappingNumberOfEntry',
    'Get-AvmWanSpecificPortMappingEntry',
    'Get-AvmWanStatusInfo',
    'Get-AvmWanTotalByteReceived',
    'Get-AvmWanTotalByteSent',
    'Get-AvmWanTotalPacketReceived',
    'Get-AvmWanTotalPacketSent',
    'Get-AvmWanTypeInfo',
    'Get-AvmWebDavClientInfo',
    'Get-AvmWlanBeaconAdvertisement',
    'Get-AvmWlanBeaconType',
    'Get-AvmWlanBssid',
    'Get-AvmWlanChannelInfo',
    'Get-AvmWlanConfigurationInfo',
    'Get-AvmWlanConnectionInfo',
    'Get-AvmWlanDeviceListPath',
    'Get-AvmWlanExternalInfo',
    'Get-AvmWlanGenericAssociatedDeviceInfo',
    'Get-AvmWlanHybridMode',
    'Get-AvmWlanIptvOptimized',
    'Get-AvmWlanNightControl',
    'Get-AvmWlanPacketStatistic',
    'Get-AvmWlanSecruityProperty',
    'Get-AvmWlanSecurityKey',
    'Get-AvmWlanSpecificAssociatedDeviceInfo',
    'Get-AvmWlanSpecificAssociatedDeviceInfoByIp',
    'Get-AvmWlanSsid',
    'Get-AvmWlanStatistic',
    'Get-AvmWlanTotalAssociation',
    'Get-AvmWlanWepKeyIndex',
    'Get-AvmWlanWpsInfo',
    'Initialize-AvmUserInterfaceCgi',
    'Update-AvmHost',
    'New-AvmDeviceUrlSid',
    'New-AvmFilelinkEntry',
    'New-AvmOnTelPhonebook',
    'Set-AvmHostNameByMac',
    'Register-AvmApp',
    'Remove-AvmFilelinkEntry',
    'Update-AvmHostFilterTickets',
    'Remove-AvmLayer3ForwardingEntry',
    'Remove-AvmMyFritzServiceByIndex',
    'Remove-AvmOnTelByIndex',
    'Remove-AvmOnTelCallBarringEntryUid',
    'Remove-AvmOnTelPhonebook',
    'Remove-AvmOnTelPhonebookEntry',
    'Remove-AvmOnTelPhoneEntryByUid',
    'Remove-AvmTamMessage',
    'Remove-AvmVoipAccount',
    'Remove-AvmVoipClient',
    'Remove-AvmWanPortMapping',
    'Remove-AvmWanPppConnectionPortMapping',
    'Request-StorageFtpServerWan',
    'Reset-AvmDevice',
    'Reset-AvmEvent',
    'Restart-AvmDevice',
    'Send-AvmDeviceSupportData',
    'Set-AvmAppMessageFilter',
    'Set-AvmAppMessageReceiver',
    'Set-AvmAppVpn',
    'Set-AvmAppVpnWithPfs',
    'Set-AvmAuthConfig',
    'Set-AvmConfigPassword',
    'Set-AvmDeviceConfigFile',
    'Set-AvmDevicePersistentData',
    'Set-AvmDeviceProvisioningCode',
    'Set-AvmFilelinkEntry',
    'Set-AvmHomeautoDeviceName',
    'Set-AvmHostAutoWakeOnLanByMac',
    'Set-AvmHostFilterTicketMarked',
    'Start-AvmHostWakeOnLanByMac',
    'Set-AvmLanAddressRange',
    'Set-AvmLanEthernetInterfaceConfigEnable',
    'Set-AvmLanInterfaceIp',
    'Set-AvmLanSubnetMask',
    'Set-AvmLayer3ForwardingDefaultConnectionService',
    'Set-AvmLayer3ForwardingEntryEnable',
    'Set-AvmManagemengServerUrl',
    'Set-AvmManagementServerConnectionRequestAuthentication',
    'Set-AvmManagementServerPassword',
    'Set-AvmManagementServerUsername',
    'Set-AvmManagementUpgrade',
    'Set-AvmMangagementServerPeriodicInform',
    'Set-AvmOnTelCallBarringEntry',
    'Set-AvmOnTelConfig',
    'Set-AvmOnTelDectHandsetPhonebook',
    'Set-AvmOnTelPhonebookEntry',
    'Set-AvmOnTelPhonebookEntryUid',
    'Set-AvmRemoteAccessConfig',
    'Set-AvmRemoteAccessDdnsConfig',
    'Set-AvmRouterIp',
    'Set-AvmServiceByIndex',
    'Set-AvmSpeedtestConfig',
    'Set-AvmStorageFtpServer',
    'Set-AvmStorageFtpServerWan',
    'Set-AvmStorageSmbServer',
    'Set-AvmStorageUserConfig',
    'Set-AvmTamMarkMessage',
    'Set-AvmTimeNtpServer',
    'Set-AvmUpnpConfig',
    'Set-AvmUserInterfaceConfig',
    'Set-AvmUserInterfaceInternationalConfig',
    'Set-AvmVoipAlarmClockEnable',
    'Set-AvmVoipClient',
    'Set-AvmVoipClient2',
    'Set-AvmVoipClient3',
    'Set-AvmVoipClient4',
    'Set-AvmVoipCommonAreaCode',
    'Set-AvmVoipCommonCountryCode',
    'Set-AvmVoipConfig',
    'Set-AvmVoipDelayedCallNotification',
    'Set-AvmVoipDialConfig',
    'Set-AvmVoipEnableAreaCode',
    'Set-AvmVoipEnableCountryCode',
    'Set-AvmWanAccessType',
    'Set-AvmWanConfig',
    'Set-AvmWanConnectionTrigger',
    'Set-AvmWanConnectionType',
    'Set-AvmWanDslConfigDestinationAddress',
    'Set-AvmWanDslLinkConfigAtmEncapsulation',
    'Set-AvmWanDslLinkConfigEnable',
    'Set-AvmWanDslLinkConfigType',
    'Set-AvmWanIdleDisconnectTime',
    'Set-AvmWanPppConnectionIdleDisconnectTime',
    'Set-AvmWanPppConnectionPassword',
    'Set-AvmWanPppConnectionRouteProtocolRx',
    'Set-AvmWanPppConnectionType',
    'Set-AvmWanPppConnectionUserName',
    'Set-AvmWanPppConnectoinAutoDisconnectTimeSpan',
    'Set-AvmWanPppConnectoinTrigger',
    'Set-AvmWanRouteProtocolRx',
    'Set-AvmWebDavClientConfig',
    'Set-AvmWlanBasBeaconSecurityProperty',
    'Set-AvmWlanBeaconAdvertisment',
    'Set-AvmWlanBeaconType',
    'Set-AvmWlanChannel',
    'Set-AvmWlanDefaultWepKeyIndex',
    'Set-AvmWlanEnable',
    'Set-AvmWlanGlobalEnable',
    'Set-AvmWlanHighFrequencyBand',
    'Set-AvmWlanHybridMode',
    'Set-AvmWlanIptvOptimized',
    'Set-AvmWlanSsid',
    'Set-AvmWlanStickSurfEnable',
    'Set-AvmWlanWepSecurityKey',
    'Set-AvmWlanWpsConfig',
    'Start-AvmDeviceConfiguration',
    'Start-AvmVoipDial',
    'Start-AvmWanConnection',
    'Start-AvmWanPppConnection',
    'Stop-AvmVoipDial',
    'Stop-AvmWanConnection',
    'Stop-AvmWanPppConnection',
    'Switch-AvmHomeautoDevice',
    'Update-AvmDectDevice',
    'Update-AvmHomeplugDevice',
    'Update-AvmUserInterface',
    'Update-AvmUserInterfaceManually'
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
        Tags = @('api', 'avm', 'avmtools', 'fritz', 'fritzbox', 'tr064', 'tr-064')

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