# Athlety

Athlety is an iOS application for track and field athletes, coaches, and anyone interested in athletics in Germany.

The app provides an overview of upcoming competitions and events and allows you to save important dates for quick access.
It is designed to help you stay organized throughout the athletics season.
All competition data comes from the official LADV (Leichtathletik-Datenverarbeitung) API.

Athlety is developed and published by Stefan Lipp in Regensburg, Germany.
Your feedback and suggestions are always welcome at [hello@athlety.app](mailto:hello@athlety.app) and help improve the app.
Athlety is available for free on the [App Store](https://apps.apple.com/app/id6761119486).

## Features

Athlety currently supports the following functionality:
- Get an overview of upcoming track & field events in Germany
- Filter upcoming events by state association or discipline
- Recognize World Ranking Competitions by their label and filter for them
- View event details like disciplines, registration deadlines, links, and the venue on a map
- View documents like the official announcement or schedule for events
- Export individual events to your personal calendar
- Save events as bookmarks for quick access
- Synchronize saved events between devices via iCloud
- Choose between a light, dark, or system appearance

## Getting Started

### Requirements

- Xcode 26 or later
- iOS 26 or later (iPhone and iPad)
- An API key for the LADV API

The project has no external dependencies and only uses Apple frameworks.

### Configuration

The project setup assumes that there exists an _AppConfig.plist_ file within the _Athlety_ directory,
which includes the base URL and an API key for the public LADV API.
An _AppConfig.sample.plist_ file serves as a reference for this and already contains the base URL.
Copy it to _AppConfig.plist_ and enter your own LADV API key:

```bash
cp Athlety/AppConfig.sample.plist Athlety/AppConfig.plist
```

The _AppConfig.plist_ file is ignored by Git, so your API key won't be committed.
The app stops at launch if the file or one of its values is missing.

### Building

Open _Athlety.xcodeproj_ in Xcode and run the _Athlety_ scheme, or build from the command line:

```bash
xcodebuild -project Athlety.xcodeproj -scheme Athlety -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

### Formatting

The code is formatted with [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) using its default rules.
The Swift version is set in the _.swift-version_ file.

```bash
swiftformat .
```

## Project Structure

- _Athlety_ contains the app source code, organized by feature (for example _Events_, _Bookmarks_, and _Calendar_)
- _LADV_ contains the documentation of the LADV API
- _docs_ contains the website for [athlety.app](https://athlety.app), including the privacy policy and imprint
