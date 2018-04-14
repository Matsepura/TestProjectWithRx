//
//  CountryList.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

struct CountryList: Decodable, JSONCodable {
    let name: String
    let population: Int
}

struct CountryListData: Decodable, JSONCodable {
    let countries: [CountryList]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var array: [CountryList] = []
        while !container.isAtEnd {
            array.append(try container.decode(CountryList.self))
        }
        countries = array
    }
}
