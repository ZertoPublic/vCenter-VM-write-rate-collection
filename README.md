# vCenter-VM-write-rate-collection
PowerShell and PowerCLI script that uses the Get-VM and Get-Stat cmdlets to collect average VM write rates and output this data to a CSV file.

Before executing this script, review the instructions below and modify the script as instructed.


1. Review the the vCenter statistics level settings, and consider the potential impact of an increase in the statistics level. When the level is increased, the vCenter database will consume more disk space, relative to how many hosts and VMs are in vCenter inventory. VMware provides an estimate of the size increase, when preparing to adjust this setting in the vSphere web client.

    https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vcenter.configuration.doc/GUID-B2F91FDE-F7FC-46C4-91D0-7AD7E4CC87FC.html<br>
    "Statistic collection intervals determine the frequency at which statistic queries occur, the length of time statistical data is stored in the database, and the type of statistical data that is collected."

2. Confirm how long to collect statistics before enough average write rate data is available. Once the statistic level is changed, it will begin retaining data. There is no way for vCenter to retroactively collect data.
     Wait for enough average write rate data to be collected.

3. Review the prerequisites for the example PowerCLI script provided in the Zerto Scale and Benchmarking Guidelines.<br>
     Install PowerCLI: https://developer.vmware.com/powercli/installation-guide<br>
     Connect to Environment: https://developer.vmware.com/docs/powercli/latest/products/vmwarevsphereandvsan/

4. Launch the Windows PowerShell ISE, or your preferred scripting application.

5. Install the PowerCLI module from the PowerShell Gallery, or manually if no direct Internet connection is available:<br>
	  Install-Module -Name VMware.PowerCLI
	
6. If needed, temporarily configure the PowerShell session to use TLS 1.2:<br>
	  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

7. Import the module:<br>
	  Import-Module VMware.VimAutomation.Core

8. If needed, set the certificate acceptance settings for the current session:<br>
    https://code.vmware.com/doc/Set-PowerCLIConfiguration.html<br>
    Set-PowerCLIConfiguration -Scope Session -InvalidCertificateAction Warn
		
9. Connect to the vCenter server hosting the VMs that will be protected:<br>
	  Connect-VIServer -Server 192.168.222.10 -Protocol https

10. Open the script in the ISE. Copy and paste it into a new file if needed.

11. Modify the example script, if needed:<br>
    Change the "adddays(-7)" section of the script to match the number of days since the vCenter statistics level has been increased (up to 30).<br>
    Change the path and file name of the CSV file that will be created.
