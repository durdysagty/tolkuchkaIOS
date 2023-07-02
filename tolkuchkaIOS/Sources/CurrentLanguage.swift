//
//  DecodeData.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 08.05.2023.
//

import Foundation

func getLocalName(ru: String, en: String, tm: String) -> String {
    let lang: String = Locale.current.languageCode!
    print(lang)
    switch lang {
    case "ru":
        return ru
    case "en" :
        return en
    case "tk":
        return tm
    default:
        return en
    }
}
