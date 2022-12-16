Office Deployment Tool (ODT)
============================

Executable file is uploaded here by a crontab job. Used by scripts to pull down the `odt_current.exe` file.

Download and extract:

```powershell
Invoke-WebRequest -Uri http://odt_current.exe -OutFile C:\tmp\OptechX\office_365\odt_current.exe -UseBasicParsing -DisableKeepAlive
Start-Process -FilePath ./odt_current -ArgumentList "/quiet","/passive","/extract:`"C:\Program Files\OfficeDeploymentTool`"" -Wait
```
