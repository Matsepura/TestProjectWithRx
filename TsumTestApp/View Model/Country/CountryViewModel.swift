//
//  CountryViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

class CountryViewModel {
    var info: String
    
    init() {
        self.info = ""
    }
    
    init(country: Country) {
        var info = ""
        info.append("Capital: ")
        info.append("\(country.capital)")
        info = info.addSpacing()
        info.append("Population: ")
        info.append("\(country.population)")
        
        if country.borders.count > 0 {
            info = info.addSpacing()
            info.append("Borders:\n")
            info.append("\(country.borders.joined(separator: "\n"))")
        }
        
        info = info.addSpacing()
        info.append("Currencies:")
        country.currencies.forEach({
            info.append("\n" + $0.name + "  -  " + $0.code)
        })
        
        self.info = info
    }
}

private extension String {
    func addSpacing() -> String {
        return self + "\n\n"
    }
}
