# m122-lb2
---
# 🔗 URL Launcher via PowerShell

Ein PowerShell-Skript zum einfachen Öffnen von URLs aus einer XML-Datei mit Google Chrome

---

## 📁 Projektstruktur

```
.
├── script.ps1             # Das PowerShell-Skript
├── config.xml             # XML-Datei mit URLs
└── launch-log.csv         # Protokoll geöffneter URLs (automatisch erstellt)
```

---

## 📝 config.xml – Format
### Warum .xml?
XML-Files sind gut um Daten einfach darstellen zu lassen.

Die Datei `config.xml` muss wie folgt aufgebaut sein:

```xml
<config>
    <urls>
        <url>https://example.com</url>
        <url>https://another-site.com</url>
        <!-- Weitere URLs hier -->
    </urls>
</config>
```

---

## ▶️ Verwendung

1. Stelle sicher, dass `config.xml` im gleichen Ordner liegt wie `script.ps1`.
2. Führe das Skript mit PowerShell aus:

```powershell
.\script.ps1
```

3. Folge den Eingabeaufforderungen:
   - Wähle einzelne URLs per Index (z. B. `1,3,4`) oder öffne **alle** mit `0`.
   - Wähle den Modus: `1` für normalen Tab, `2` für Inkognito.

---

## 📓 Beispielausgabe

```
Verfügbare URLs:
1: https://example.com
2: https://another-site.com
Welche URL(s) möchtest du öffnen? (Format x,x,x (1 - 2) oder alle = 0): 1,2
Chrome normal (1) oder Inkognito (2)? (1/2): 2
```

---

## 📄 Logging

Alle geöffneten URLs werden automatisch in `launch-log.csv` protokolliert:

```
Datum;URL;Modus
2025-05-05 19:58:24;https:/www.example.com;2
```

---

## ⚠️ Voraussetzungen

- Windows mit PowerShell
- [Google Chrome](https://www.google.com/chrome/) installiert und über `chrome.exe` aufrufbar



