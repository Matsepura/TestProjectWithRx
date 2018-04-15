//
//  ServiceLayer.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

final class ServiceLayer {
    static let shared = ServiceLayer()
    let networkClient: NetworkClient
    
    let countriesService: CountriesService

    init() {
        self.networkClient = NetworkClient()
        self.countriesService = CountriesService(networkClient)
    }
}
