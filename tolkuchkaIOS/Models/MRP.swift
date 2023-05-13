//
//  MRP.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 06.05.2023.
//

import Foundation

// Models required properties

protocol MRP: Codable, Identifiable {
    var id: Int {get set}
    var version: Int {get set}
}
