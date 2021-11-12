//
//  String+Localized.swift
//  HTrack
//
//  Created by Jedi Tones on 12.11.2021.
//

import UIKit

func localized(_ string: String) -> String {
    return string.localized
}

extension String {
    fileprivate var localized: String {
        let word = Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        return word
    }
    
    func withArguments(_ arguments: [String]) -> String {
        // Проблема в stringsdict
        // Оказывается он чувствитель к Locale и важно какой язык стоит
        // Если инглиш, то берёт только one и other,
        // если русский, то one, two, few, many, other
        //
        // На примере pages_detail_users_count происходит, что
        // в инглише закидывает числовые значения в other,
        // а там стоит плейсхолдер %@ и приложение падает
        //
        // Поэтому пока костылём поставил русский по-умолчанию
        // и в этом случае всё работает
        let languageCode = "ru"//AppLanguageSetting.shared.languageCode
        var intArgs: [CVarArg] = []
        var containsInt = false
        arguments.forEach { (arg) in
            if let numb = Int(arg) {
                intArgs.append(numb)
                containsInt = true
            } else {
                intArgs.append(arg)
            }
        }
        
        // "%#@key@" value in stringsdict
        if containsInt && self.contains("%#@key@") {
            let formatStr = NSLocalizedString(self, comment: "")
            let selfstr = String(format: formatStr, locale: Locale.init(identifier: languageCode), arguments: intArgs)
            return selfstr
        } else {
            let formatStr = NSLocalizedString(self, comment: "")
            let selfstr = String(format: formatStr, arguments: arguments)
            return selfstr
        }
    }
}
