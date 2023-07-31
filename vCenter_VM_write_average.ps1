# Before executing this script, review the instructions in the README file and modify the script as instructed.
# The script will fail without making the changes described in the README file.

$report = @()
	Get-VM | %{$stats = Get-Stat -Entity $_ -Stat disk.write.average -Start (Get-Date).adddays(-7) -ErrorAction SilentlyContinue
	if($stats){
	$statsGrouped = $stats | Group-Object -Property MetricId
	$row = "" | Select Name, WriteAvgKBps, WriteAvgMBps
	$row.Name = $_.Name
	$row.WriteAvgKBps = ($statsGrouped | where {$_.Name -eq "disk.write.average"} | %{$_.Group | Measure-Object -Property Value -Average}).Average
	$row.WriteAvgMBps = $row.WriteAvgKBps/1024
	$row.WriteAvgKBps = "{0:N2}" -f $row.WriteAvgKbps
	$row.WriteAvgMBps = "{0:N2}" -f $row.WriteAvgMBps
	$report += $row
	}
}
$report | Export-Csv "C:\VM-write-average.csv"