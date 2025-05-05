$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$xmlFilePath = Join-Path $scriptPath "config.xml"
$csvLogPath = Join-Path $scriptPath "launch-log.csv"

# Falls CSV noch nicht existiert, Kopfzeile schreiben
if (-not (Test-Path $csvLogPath)) {
    "Datum;URL;Modus" | Out-File -FilePath $csvLogPath -Encoding UTF8
}

if (Test-Path $xmlFilePath) {
    [xml]$config = Get-Content -Path $xmlFilePath
    $urls = $config.config.urls.url

    if ($urls.Count -gt 0) {
        Write-Host "Verfügbare URLs:"
        for ($i = 0; $i -lt $urls.Count; $i++) {
            Write-Host "$($i+1): $($urls[$i])"
        }

        $selection = Read-Host "Welche URL(s) möchtest du öffnen? (Format x,x,x (1 - $($urls.Count)) oder alle = 0)"
        $mode = Read-Host "Chrome normal (1) oder Inkognito (2)? (1/2)"

        if ($selection -eq "0") {
            $indices = 0..($urls.Count - 1)
        } else {
            $indices = $selection -split "," | ForEach-Object {
                $num = $_.Trim()
                if ($num -match "^\d+$") { [int]$num - 1 }
            }
        }

        foreach ($i in $indices) {
            if ($i -ge 0 -and $i -lt $urls.Count) {
                $url = $urls[$i]
                if ($url -match "^https?://") {
                    if ($mode -eq "2") {
                        Start-Process "chrome.exe" -ArgumentList "--incognito", $url
                    } else {
                        Start-Process "chrome.exe" $url
                    }

                    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                    Add-Content -Path $csvLogPath -Value "$timestamp;$url;$mode"
                } else {
                    Write-Host "Ungültige URL übersprungen: $url"
                }
            } else {
                Write-Host "Ungültige Auswahl: $($i + 1)"
            }
        }
    } else {
        Write-Host "Keine URLs in der XML-Datei gefunden."
    }
} else {
    Write-Host "Die Datei 'config.xml' wurde am angegebenen Pfad nicht gefunden."
}
