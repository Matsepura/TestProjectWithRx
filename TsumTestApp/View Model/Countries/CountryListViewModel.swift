//
//  CountryListViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

final class CountryListViewModel {
    let name: String
    let population: String
    
    init(country: CountryList) {
        self.name = country.name
        self.population = "👨‍👩‍👧‍👦 \(country.population)"
    }
}
