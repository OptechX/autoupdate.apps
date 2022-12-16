<# initial setup #>
$root_path = "C:\tmp\OptechX\apps\office365"
if (-not(Test-Path -Path $root_path)) {
    New-Item -Path C:\ -ItemType Directory -name "tmp\OptechX\apps\office365" -Confirm:$false -Force
}

<# get the intended file #>
$download_uri = "https://www.microsoft.com/en-au/download/confirmation.aspx?id=49117"
$download_page = Invoke-WebRequest -UseBasicParsing -Uri $download_uri -DisableKeepAlive
$download_url = $download_page.Content | 
    Select-String -Pattern 'https:\/\/download\.microsoft\.com\/download.*officedeploymenttool.*\d{1,}\.exe",' | 
    Select-Object -ExpandProperty Matches -First 1 | 
    Select-Object -ExpandProperty Value
$download_url = $download_url.Replace('",','')
Invoke-WebRequest -Uri $download_url -OutFile "${root_path}\odt_current.exe" -UseBasicParsing -DisableKeepAlive

<# setup #>
Start-Process -FilePath "${root_path}\odt_current.exe" -ArgumentList "/quiet","/passive","/extract:`"C:\Program Files\OfficeDeploymentTool`"" -Wait
Remove-Item -Path "C:\Program Files\OfficeDeploymentTool\*.xml" -Confirm:$false -Force
Get-ChildItem -Path "C:\Program Files\OfficeDeploymentTool\*.exe" | ForEach-Object {
    Write-Output "File path: $($_)"
    $v = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_).FileVersion.ToString()
    Write-Output "Office Deployment Tool Version: ${v}"
}
