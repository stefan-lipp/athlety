# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Athlety is a native iOS app (Swift/SwiftUI, iOS 26+) for track and field athletes in Germany. It fetches upcoming competitions from the LADV (Leichtathletik-Datenverarbeitung) API and lets users browse, filter, bookmark, and export events to their calendar. There are no external dependencies, only Apple frameworks (SwiftUI, SwiftData, EventKit, MapKit, Foundation).

## Commands

Plain Xcode project (no SPM package). Build:

```bash
xcodebuild -project Athlety.xcodeproj -scheme Athlety -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

Formatting uses SwiftFormat with default rules (no `.swiftformat` file; `.swift-version` pins Swift 6.0):

```bash
swiftformat --lint .   # check
swiftformat .          # apply
```

There is no test target.

### Setup

Copy `Athlety/AppConfig.sample.plist` to `Athlety/AppConfig.plist` (gitignored) and fill in the LADV API key. `AppConfig.shared` calls `fatalError` if the file or its `LADV.BaseURL` / `LADV.APIKey` values are missing.

## Architecture

MVVM with protocol-based API clients and SwiftData persistence, organized by feature under `Athlety/` (`Events/` is the core feature; `Bookmarks/`, `Associations/`, `Calendar/`, `Disciplines/`, `Settings/`, `About/`, `Welcome/`, and the shared `Library/`).

Outside the app target, `LADV/` holds the LADV API documentation (PDF) and `docs/` is the static athlety.app website (privacy policy, imprint).

### Concurrency

Swift 6 language mode with Approachable Concurrency and default actor isolation `MainActor`. Views, ViewModels, and SwiftData stay on the main actor. API clients are `nonisolated` + `Sendable` with `@concurrent` async methods so fetching and decoding run off the main actor. Domain models that cross that boundary (`Event`, `EventDetails`, `EventsFilter`, `Discipline`, `Association`) are `nonisolated` + `Sendable`.

### Data flow

LADV API → `LadvEventsClient` / `LadvAssociationsClient` → `Sendable` domain models → `@Observable` ViewModels → SwiftUI views.

- Clients implement a protocol (`EventsClient`, `AssociationsClient`) and take the base URL and API key in `init`, defaulting to `AppConfig.shared`. They use `URLSession` directly and swallow network and decoding errors, returning an empty array or `nil`.
- LADV response models are `Ladv*` structs, private to the client file, and mapped to domain models there.
- App-wide ViewModels (`EventsOverviewViewModel`, `CalendarEventViewModel`) are created with `@State` in `AthletyApp` and passed down via `.environment(...)`. Screen-local ones (`EventDetailsViewModel`) are owned by their view.

### Navigation and filtering

- `EventsOverview` is a `NavigationSplitView`. The list's `selectedEventId` drives the detail column, and `EventDetailsView` reloads with `.task(id: eventId)`. The settings button sits in the list toolbar on compact width and in the detail toolbar otherwise (`SettingsToolbarButton`).
- The filter lives in `@AppStorage` under the `eventsFilter*` keys, read by both `EventsFilterView` and `EventsOverview`. The filter sheet edits a local draft and only writes to `@AppStorage` on "Done". `EventsOverview` builds an `EventsFilter` from those keys and loads with `.task(id: filter)`, so changing the filter cancels the outdated request.

### Persistence

`EventBookmark` is the only SwiftData model (`.modelContainer(for: EventBookmark.self)` on the `WindowGroup`) and syncs through CloudKit. CloudKit requires every property to have a default value and doesn't allow unique constraints.

Adding a field to events usually touches the `Ladv*` response model and its mapping, `Event` / `EventDetails`, and `EventBookmark` (a stored property with a default, both convenience inits, and `toEvent()`) so saved events keep the field.

### Localization

`Localizable.xcstrings` uses English as the source language with German translations. Every new user-facing string needs a German translation. German copy calls events "Wettkämpfe".
