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
        return ru
    }
}

func getLocalNumber() -> Int {
    let lang: String = Locale.current.languageCode!
    print(lang)
    switch lang {
    case "ru":
        return 0
    case "en" :
        return 1
    case "tk":
        return 2
    default:
        return 0
    }
}

func getLocal() -> String {
    let lang: String = Locale.current.languageCode!
    switch lang {
    case "ru":
        return "ru."
    case "en" :
        return "en."
    case "tk":
        return "tm."
    default:
        return "ru."
    }
}
