import SwiftUI

struct LanguagePreferencesView: View {
    @ObservedObject var model: LanguagePreferencesModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Form {
                    Section {
                        Picker(NSLocalizedString("language.title", comment: ""), selection: $model.selectedLanguage) {
                            ForEach(AppLanguage.allCases, id: \.self) { language in
                                Text(language.displayName).tag(language)
                            }
                        }
                        .pickerStyle(.inline)
                    } header: {
                        Text(NSLocalizedString("language.title", comment: ""))
                    } footer: {
                        Text(NSLocalizedString("language.footer", comment: ""))
                    }
                }
                .formStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
            .frame(maxWidth: 600)
            .padding(20)
        }
    }
}

#Preview {
    LanguagePreferencesView(model: LanguagePreferencesModel())
}
