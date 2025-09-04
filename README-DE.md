# LinArt iOS App

LinArt ist eine umfassende Projektverwaltungsanwendung, die speziell für Kreativprofis, Freelancer und Unternehmen in der Kunst- und Kreativbranche entwickelt wurde. Mit SwiftUI und iOS 16+ erstellt, bietet sie eine vollständige Lösung für die Verwaltung von Projekten, die Verfolgung von Vermietungen, die Aufzeichnung von Ausgaben und die Organisation von Dokumenten.

## Funktionen

### 🗂️ Projektverwaltung
- Erstellen und organisieren Sie Projekte mit detaillierten Beschreibungen
- Verfolgen Sie den Projektstatus (Aktiv, In Bearbeitung, Pausiert, Abgeschlossen)
- Visuelle Projektstatistiken und Übersicht
- Projektbasierte Organisation für alle anderen Daten

### 📅 Vermietungsworkflow
- Verfolgen Sie Vermietungsartikel mit Start- und Enddaten
- Verwalten Sie Vermietungskosten und -status
- Verknüpfen Sie Vermietungen mit spezifischen Projekten
- Verwaltung und Verfolgung von Vermietungszeiträumen

### 💰 Ausgabenverwaltung
- Erfassen Sie Ausgaben mit Kategorien und Beschreibungen
- Beleg-Scanning mit OCR-Funktionen
- Automatische Extrahierung von Ausgabendaten aus Belegen
- Projektbasierte Ausgabenverfolgung

### 📄 Dokumentenverwaltung
- Vorgefertigte Dokumentvorlagen (Rechnung, Vertrag, Beleg, Kostenvoranschlag, Bericht)
- Ausweis-Erfassung und sichere Dokumentenspeicherung
- Dateiorganisation und -verwaltung
- Vorlagenbasierte Dokumentenerstellung

### ☁️ Cloud-Integration
- CloudKit-Synchronisation zwischen Geräten
- Automatische Sicherung und Synchronisation
- Geräteübergreifende Datenkonsistenz

### 📤 Export & Teilen
- Mehrere Exportformate (PDF, CSV, JSON)
- Konfigurierbare Exportoptionen
- Projektbasierte Exportfunktionen
- Datenfreigabefunktionalität

### 🌍 Lokalisierung
- Unterstützung für Englisch und Deutsch
- Lokalisierte Benutzeroberfläche
- Kulturelle Anpassungen für verschiedene Regionen

## Technische Anforderungen

- **iOS**: 16.0+
- **Xcode**: 14.0+
- **Swift**: 5.0+
- **Frameworks**: SwiftUI, Core Data, CloudKit, AVFoundation, VisionKit

## Architektur

### Kernkomponenten
- **SwiftUI**: Modernes deklaratives UI-Framework
- **Core Data**: Lokale Datenpersistenz mit CloudKit-Integration
- **CloudKit**: Cloud-Synchronisation und Backup
- **MVVM-Pattern**: Saubere Trennung der Belange

### Datenmodell
- **Project**: Zentrale Entität zur Arbeitsorganisation
- **Rental**: Verfolgung von Vermietungsartikeln
- **Expense**: Finanzielle Aufzeichnungen
- **Document**: Datei- und Vorlagenverwaltung

### Implementierung der Hauptfunktionen
- **Beleg-Scanning**: Kameraintegration mit OCR-Verarbeitung
- **Ausweis-Erfassung**: Sichere Dokumentenerfassung und -speicherung
- **Dokumentvorlagen**: Vorformatierte Geschäftsdokumente
- **Exportsystem**: Flexibler Datenexport in mehreren Formaten

## Projektstruktur

```
LinArt/
├── LinArt/
│   ├── LinArtApp.swift                 # App-Einstiegspunkt
│   ├── ContentView.swift               # Haupt-Tab-Navigation
│   ├── Core/
│   │   ├── DataModel.xcdatamodeld/     # Core Data Modell
│   │   └── PersistenceController.swift # Datenpersistenz
│   ├── Features/
│   │   ├── Projects/                   # Projektverwaltung
│   │   ├── Rentals/                    # Vermietungsverfolgung
│   │   ├── Expenses/                   # Ausgabenverwaltung
│   │   ├── Documents/                  # Dokumentenbehandlung
│   │   └── Settings/                   # App-Konfiguration
│   └── Resources/
│       ├── Assets.xcassets             # App-Icons und Farben
│       ├── Info.plist                  # App-Konfiguration
│       └── Localizations/              # Mehrsprachige Unterstützung
├── LinArtTests/                        # Unit-Tests
└── README.md                          # Projektdokumentation
```

## Installation & Einrichtung

1. **Repository klonen**
   ```bash
   git clone https://github.com/Vikinges/LinArt-iOS-DE-App-.git
   cd LinArt-iOS-DE-App-
   ```

2. **In Xcode öffnen**
   ```bash
   open LinArt.xcodeproj
   ```

3. **CloudKit konfigurieren** (Optional)
   - CloudKit-Fähigkeit in den Projekteinstellungen aktivieren
   - CloudKit-Container im Apple Developer Portal konfigurieren
   - Container-Identifier in den Projekteinstellungen aktualisieren

4. **Erstellen und Ausführen**
   - Zielgerät oder Simulator auswählen
   - Cmd+R drücken zum Erstellen und Ausführen

## Verwendung

### Erste Schritte
1. Starten Sie die App, um die Haupt-Tab-Oberfläche zu sehen
2. Beginnen Sie mit der Erstellung Ihres ersten Projekts im Projekte-Tab
3. Fügen Sie Vermietungen, Ausgaben und Dokumente nach Bedarf hinzu
4. Verwenden Sie die Exportfunktionalität zum Generieren von Berichten

### Projektverwaltung
- Tippen Sie auf die "+"-Schaltfläche, um neue Projekte zu erstellen
- Verwenden Sie die Projektdetailansicht für Schnellaktionen
- Verfolgen Sie den Projektfortschritt mit Statusupdates

### Vermietungsverfolgung
- Fügen Sie Vermietungsartikel mit Daten und Kosten hinzu
- Verknüpfen Sie Vermietungen mit spezifischen Projekten
- Überwachen Sie Vermietungszeiträume und -ausgaben

### Ausgabenerfassung
- Fügen Sie Ausgaben manuell hinzu oder scannen Sie Belege
- Kategorisieren Sie Ausgaben für bessere Organisation
- Generieren Sie Ausgabenberichte nach Projekt

### Dokumentenverwaltung
- Verwenden Sie Vorlagen für gängige Geschäftsdokumente
- Erfassen Sie Ausweisdokumente sicher
- Organisieren Sie Dokumente nach Projekt

## Datenschutz & Berechtigungen

Die App fordert folgende Berechtigungen an:
- **Kamera**: Für Beleg-Scanning und Ausweis-Erfassung
- **Fotobibliothek**: Zum Importieren von Bildern und Dokumenten
- **CloudKit**: Für Datensynchronisation (optional)

Alle Daten werden lokal gespeichert und über Ihr persönliches iCloud-Konto synchronisiert. Keine Daten werden an Dritte weitergegeben.

## Testen

Führen Sie die Test-Suite aus, um die Funktionalität zu überprüfen:

```bash
# In Xcode
Cmd+U
```

Die Test-Suite umfasst:
- Core Data Modellvalidierung
- Entity-Beziehungstests
- Persistence Controller Funktionalität
- Datenintegritätsprüfung

## Lokalisierung

Derzeit unterstützte Sprachen:
- **Englisch** (en): Primärsprache
- **Deutsch** (de): Vollständige Lokalisierung

Um neue Sprachen hinzuzufügen:
1. Erstellen Sie einen neuen `.lproj`-Ordner in Resources
2. Fügen Sie eine `Localizable.strings`-Datei hinzu
3. Aktualisieren Sie die Projekt-Lokalisierungseinstellungen

## Mitwirken

1. Repository forken
2. Feature-Branch erstellen
3. Änderungen vornehmen
4. Tests für neue Funktionalität hinzufügen
5. Pull Request einreichen

## Lizenz

Dieses Projekt wurde zu Demonstrationszwecken erstellt. Bitte beachten Sie die Repository-Lizenz für Nutzungsbedingungen.

## Support

Für Support und Fragen:
- Erstellen Sie ein Issue im GitHub-Repository
- Prüfen Sie die Dokumentation für häufige Lösungen
- Überprüfen Sie die Test-Suite für Implementierungsbeispiele

## Roadmap

Geplante zukünftige Verbesserungen:
- Zusätzliche Dokumentvorlagen
- Erweiterte OCR-Funktionen
- Verbesserte Exportoptionen
- Team-Kollaborationsfunktionen
- Erweiterte Berichterstattung und Analytik

---

**LinArt** - Optimierung des kreativen Projektmanagements, ein Projekt nach dem anderen.