import Foundation
import SwiftUI

enum AppLanguage: String, CaseIterable {
    case system = "system"
    case english = "en"
    case chinese = "zh-Hans"
    
    var displayName: String {
        switch self {
        case .system:
            return NSLocalizedString("language.system", comment: "")
        case .english:
            return NSLocalizedString("language.english", comment: "")
        case .chinese:
            return NSLocalizedString("language.chinese", comment: "")
        }
    }
    
    var identifier: String? {
        switch self {
        case .system:
            return nil
        case .english:
            return "en"
        case .chinese:
            return "zh-Hans"
        }
    }
}

class LanguagePreferencesModel: ObservableObject {
    @Published var selectedLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: "app.language")
            applyLanguage()
        }
    }
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "app.language") ?? "system"
        selectedLanguage = AppLanguage(rawValue: savedLanguage) ?? .system
        applyLanguage()
    }
    
    private func applyLanguage() {
        if let identifier = selectedLanguage.identifier {
            UserDefaults.standard.set([identifier], forKey: "AppleLanguages")
        } else {
            UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        }
        UserDefaults.standard.synchronize()
    }
}
