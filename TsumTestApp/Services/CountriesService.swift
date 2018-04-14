//
//  CountriesService.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import Moya

typealias CountriesListClosure = (CountryListData) -> Void
typealias CountryClosure = (CountryData) -> Void

final class CountriesService: Service {
    func obtainCountriesList(completion: @escaping CountriesListClosure,
                             errorClosure: @escaping ErrorClosure) {
        let target = MultiTarget( CountriesProvider.countriesList )
        networkClient.requestWithoutBody(target: target,
                                         successClosure: { (data) in
                                            completion(data)
        }, failureClosure: errorClosure)
    }
    
    func obtainCountry(name: String,
                       completion: @escaping CountryClosure,
                       errorClosure: @escaping ErrorClosure) {
        let target = MultiTarget( CountriesProvider.countryInfo(name: name) )
        networkClient.requestWithoutBody(target: target,
                                         successClosure: { (data) in
                                            completion(data)
        }, failureClosure: errorClosure)
    }
}
