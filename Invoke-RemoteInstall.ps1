
Set-Location C:\Tools\
Write-Output "Enter Remote ComputerName:"
$computername  = Read-Host
try
{
.\PsExec.exe \\$computername\ powershell Enable-PSSessionConfiguration -force 
}
Catch{}

Write-Output "Select Program"
$Program = Read-Host
New-Item -path \\$computername\C$\temp\ -ItemType Directory
Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\Common\* -Destination \\$computername\C$\temp\
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\anyconnect-win-4.5.00058-core-vpn-webdeploy-k9.exe -ArgumentList /qn -wait; Remove-item C:\temp\anyconnect-win-4.5.00058-core-vpn-webdeploy-k9.exe -force }
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\Teams_windows_x64.exe -ArgumentList /silent -wait; Remove-Item C:\temp\Teams_windows_x64.exe}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process 'C:\temp\Firefox Setup 73.0.1.exe' -ArgumentList /silent -Wait; Remove-Item 'C:\temp\Firefox Setup 73.0.1.exe' -force}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process msiexec.exe -ArgumentList "/i C:\temp\GoogleChromeStandaloneEnterprise64.msi /qn" -wait; Remove-Item C:\temp\GoogleChromeStandaloneEnterprise64.msi -force}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process msiexec.exe -ArgumentList "/i C:\temp\7z1900-x64.msi /q" -wait; Remove-Item C:\temp\7z1900-x64.msi -force}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\AVsetup.exe -ArgumentList /s -wait; Remove-item C:\temp\AVsetup.exe -force}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\jre-8u201-windows-i586.exe -ArgumentList /s -wait}
Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\AcroRdrDC2000620034_en_US.exe -ArgumentList /silent; Start-Sleep 60;Remove-Item C:\temp\AcroRdrDC2000620034_en_US.exe -force}

switch  ($Program) {            
                 { $_ -in 'Ariba' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\Ariba\* -Destination \\$computername\C$\temp\
                Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\CitrixWorkspaceApp.exe -ArgumentList /silent; start-sleep 60;restart-computer -force}

            }
                 { $_ -in 'Elekta' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\Elekta\* -Destination \\$computername\C$\temp\
                Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\CitrixWorkspaceApp.exe -ArgumentList /silent; start-sleep 60;restart-computer -force}

            }
                 { $_ -in 'Shared' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\DellSchneiderFlash\* -Destination \\$computername\C$\temp\
            }
                 { $_ -in 'HP' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\HP\* -Destination \\$computername\C$\temp\
                Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\Dynamics365-USD-4.1.1.1319-amd64.exe.exe -ArgumentList 'install Shortcut=y /S'; start-sleep 120;restart-computer -force}
                Write-Output "Testing some stuff!!!!!!!!!!!"
            }
                 { $_ -in 'Thermo' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\ThermoFisher\* -Destination \\$computername\C$\temp\
            }
                 { $_ -in 'Varian' } {            
                Copy-Item -Path \\soffs01.sophia.onprocess.local\d$\AppsSofia\ByProgramName\Varian\* -Destination \\$computername\C$\temp\
                Invoke-Command -ComputerName $computername -ScriptBlock {Start-Process C:\temp\CitrixReceiver.exe -ArgumentList /silent; start-sleep 60;restart-computer -force}

            }
            
            Default { Write-Output "This Program does not exist!" }
        }



