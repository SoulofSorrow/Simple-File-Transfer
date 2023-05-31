# Skript zur Dateiübertragung und Löschung

Dieses Bash-Skript dient zur Übertragung von Dateien auf einen Zielhost und anschließenden Löschung der lokalen Dateien. Der Zielhost wird durch die Variable `HOSTSERVER` definiert, die den Hostnamen und den Pfad zur Zielverzeichnisstruktur enthält.

## Hauptfunktion (`main`)

Die Hauptfunktion des Skripts besteht aus einer Schleife, die alle Hosts in der `HOSTSERVER`-Variable durchläuft. Für jeden Host wird zuerst eine Ping-Überprüfung durchgeführt, um die Erreichbarkeit zu prüfen. Wenn der Host erreichbar ist, werden alle Dateien im Verzeichnis `/home/test` gesammelt und nacheinander auf den Zielhost übertragen. Nach jeder erfolgreichen Übertragung wird eine Erfolgsmeldung in ein Log-Datei geschrieben. Wenn eine Übertragung fehlschlägt, wird eine Fehlermeldung in das Log-Datei geschrieben und es wird eine Pause von 5 Minuten eingelegt, bevor ein erneuter Übertragungsversuch unternommen wird.

Wenn ein Host nicht erreichbar ist, wird eine entsprechende Fehlermeldung ausgegeben. 

Nach Abschluss aller Übertragungen ruft die `main`-Funktion die `submain`-Funktion auf, um die Dateien zu löschen, sofern alle Übertragungen erfolgreich waren.

## Hilfsfunktionen

- `trans`: Diese Funktion überträgt eine einzelne Datei auf den Zielhost mithilfe des `scp`-Befehls. Die Funktion enthält eine Schleife, die die Übertragung wiederholt, falls sie fehlschlägt. Nach erfolgreicher Übertragung wird eine Erfolgsmeldung in das Log-Datei geschrieben, andernfalls eine Fehlermeldung. Die Funktion gibt `true` zurück, wenn die Übertragung erfolgreich war, andernfalls `false`.

- `pingfunction`: Diese Funktion überprüft die Erreichbarkeit eines Hosts mithilfe des `ping`-Befehls. Eine erfolgreiche Ping-Überprüfung wird in das Log-Datei festgehalten und die Funktion gibt `true` zurück. Bei einem Fehlschlag wird eine entsprechende Fehlermeldung geschrieben und die Funktion gibt `false` zurück.

- `deletefile`: Diese Funktion löscht alle lokal gespeicherten Dateien, wenn die Übertragungen erfolgreich waren. Eine Erfolgsmeldung wird in das Log-Datei geschrieben, wenn das Löschen erfolgreich war, andernfalls eine Fehlermeldung.

## Verwendung

Das Skript kann direkt ausgeführt werden, indem es in einer Bash-Umgebung aufgerufen wird.

Bitte beachten Sie, dass die Pfade zu den Log-Dateien und den Verzeichnissen entsprechend angepasst werden müssen, um Ihren spezifischen Anforderungen gerecht zu werden.
