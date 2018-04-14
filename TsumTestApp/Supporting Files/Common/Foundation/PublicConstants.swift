//
//  PublicConstants.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

enum PublicConstants {
    static let apiBase = "https://restcountries.eu/rest/"
    static let apiVersion = "v2/"
    static let contentType = "application/json; charset=utf-8"
    static let jsonHeaders = ["Content-Type": "application/json"]
    
    static let error = NSLocalizedString("Error")
    static let cancel = NSLocalizedString("Cancel")
    
    static let newLine = "\n"
}
