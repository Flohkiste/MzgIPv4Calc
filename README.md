# MZG IPv4 Calculator – Installationsanleitung

Dies ist ein einfacher IPv4-Subnetzrechner, entwickelt mit Flutter. Die Anwendung berechnet Netzwerkdaten basierend auf IP-Adresse und Subnetzmaske.

## Voraussetzungen

* Flutter SDK: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
* Git
* Xcode (für macOS) oder Android Studio (für Android)
* macOS, Windows oder Linux (abhängig vom Zielsystem)

## Installation

```bash
git clone https://github.com/Flohkiste/MzgIPv4Calc.git
cd MzgIPv4Calc
flutter pub get
```

## Anwendung starten

### macOS

```bash
flutter run -d macos
```

### Windows

```bash
flutter run -d windows
```

### Linux

```bash
flutter run -d linux
```

### Web

```bash
flutter run -d chrome
```

## Build erstellen

### macOS

```bash
flutter build macos
```

Die fertige App befindet sich dann unter:

```
build/macos/Build/Products/Release/
```

### Windows

```bash
flutter build windows
```

### Linux

```bash
flutter build linux
```

## Tests ausführen

```bash
flutter test
```

## Lizenz

Dieses Projekt steht unter der MIT-Lizenz.
