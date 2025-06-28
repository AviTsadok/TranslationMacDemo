import SwiftUI
import Translation

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var translatedText: String = ""
    @State private var isTranslating: Bool = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter text", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Button("Translate to Japanese") {
                Task {
                    await translateFunctionTapped()
                }
            }
            .buttonStyle(.borderedProminent)
            if isTranslating {
                ProgressView("Translating...")
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            Text(translatedText)
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
    
    private func translateFunctionTapped() async {
        isTranslating = true
        errorMessage = nil
        translatedText = ""
        let availability = LanguageAvailability()
        let status = await availability.status(from: Locale.Language(identifier: "en-US"), to: Locale.Language(identifier: "ja"))
        guard status == .installed else {
            isTranslating = false
            errorMessage = "Japanese translation is not available on this device."
            return
        }
        let session = TranslationSession(installedSource: Locale.Language(identifier: "en-US"), target: Locale.Language(identifier: "ja"))
        do {
            let response = try await session.translate(inputText)
            translatedText = response.targetText
        } catch {
            errorMessage = "Translation failed: \(error.localizedDescription)"
        }
        isTranslating = false
    }
}
