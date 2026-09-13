# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Athlety is a native iOS app (Swift/SwiftUI) for track and field athletes in Germany. It fetches upcoming competition data from the LADV (Leichtathletik-Datenverarbeitung) API and lets users browse, filter, bookmark, and export events to their calendar.

## Build & Run

This is an Xcode project (no SPM package, no external dependencies). Build and run using:

```bash
xcodebuild -project Athlety.xcodeproj -scheme Athlety -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```

There are no tests in the project currently.

### Setup Requirement

Before building, copy `Athlety/AppConfig.sample.plist` to `Athlety/AppConfig.plist` and add your LADV API key. The `AppConfig.plist` is gitignored.

## Architecture

**Pattern:** MVVM with protocol-based API clients and SwiftData persistence.

**Language / concurrency:** Swift 6 language mode with Approachable Concurrency and default actor isolation `MainActor`. UI, ViewModels, and SwiftData stay on the main actor. Networking clients are `nonisolated` + `Sendable` with `@concurrent` async methods so fetch/decode run off the main actor. Domain models that cross that boundary are `nonisolated` + `Sendable`.

**Feature-based structure** — each feature lives in its own directory under `Athlety/`:

| Directory | Purpose |
|-----------|---------|
| `App/` | Entry point (`AthletyApp`), `AppConfig` singleton for API credentials |
| `Events/` | Core feature: fetching, displaying, and filtering events (Clients, Models, ViewModels, Views) |
| `Bookmarks/` | SwiftData `EventBookmark` model for persisting saved events (synced via iCloud) |
| `Associations/` | State association data for filtering events by region |
| `Calendar/` | EventKit integration for exporting events |
| `Disciplines/` | `Discipline` enum (~50 athletic disciplines) with `Category`-based grouping |
| `Settings/` | Appearance preferences via `@AppStorage` |
| `Welcome/` | Onboarding flow |
| `Library/` | Shared utilities: `WrappingHStack` (custom Layout), extensions |

### Key Patterns

- **API clients** follow a protocol/implementation split: `EventsClient` protocol → `LadvEventsClient` implementation; `AssociationsClient` → `LadvAssociationsClient`. Clients take LADV base URL/API key in `init` (defaults from `AppConfig.shared`).
- **ViewModels** are `@Observable` classes (MainActor by default), injected at the app root with `@State` and consumed via `.environment(...)`.
- **Persistence** uses SwiftData with a `.modelContainer(for: EventBookmark.self)` on the app's WindowGroup.
- **Networking** uses async/await with URLSession directly (no third-party HTTP library); client methods are `@concurrent`.
- **Localization** uses a string catalog (`Localizable.xcstrings`).
- **No external dependencies** — only Apple frameworks (SwiftUI, SwiftData, EventKit, Foundation).

### Data Flow

LADV API → `LadvEventsClient` (`@concurrent`) → `Sendable` domain models (`Event`, `EventDetails`) → MainActor ViewModels → SwiftUI Views. API response models are prefixed with `Ladv*` and mapped to domain models in the client layer.
