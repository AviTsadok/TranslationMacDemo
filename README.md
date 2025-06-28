# On-Device Translation Demo

This project demonstrates how to use Apple's Translation framework to perform fast, private, and on-device language translations in SwiftUI.

## Features
- Enter English text and translate it to Japanese using only on-device resources.
- Shows translation progress and handles common errors.

## Requirements
- Xcode 15 or newer (Tested with Xcode 26.0)
- iOS 17.0+, macOS 14+, or compatible platform supporting the Translation framework

## Getting Started
1. Open this project in Xcode.
2. Build and run on a device or simulator that supports the Translation framework.
3. Type an English phrase into the text field and tap 'Translate to Japanese'.

## How On-Device Translation Works
The Translation framework allows you to:
- Check if a language pair is available for translation on device
- Translate text between supported languages

Here's a basic example based on this demo:

```swift
import Translation

let availability = LanguageAvailability()
let status = await availability.status(from: Locale.Language(identifier: "en-US"), to: Locale.Language(identifier: "ja"))
if status == .installed {
    let session = TranslationSession(installedSource: Locale.Language(identifier: "en-US"), target: Locale.Language(identifier: "ja"))
    let result = try await session.translate("Hello, world!")
    print("Japanese: \(result.targetText)")
} else {
    print("Japanese translation is not available on this device.")
}
