//
//  Localizable.swift
//  SyncracyTest
//
//  Created by Anil on 04/04/21.
//

import UIKit

private let appleLanguagesKey = "AppleLanguages"

enum LanguageName : String{
    case english = "English"
    case arabic = "Arabic"
}

enum Language: String {
    
    case english = "en"
    case arabic = "ar"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .english:
            return .forceLeftToRight
        case .arabic:
            return .forceRightToLeft
        }
    }
    
    
    static var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                //preferredLanguage.substring(to: index)
                guard let localization = Language(
                    rawValue: String(preferredLanguage[..<index])
                    ) else {
                        return Language.english
                }
                
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }

            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
        
            UIView.appearance().semanticContentAttribute = newValue.semantic
            
        }
    }
}


extension String {
    
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
}

extension Bundle {

    static var localizedBundle: Bundle {
        let languageCode = Language.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
