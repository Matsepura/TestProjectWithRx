//
//  CountryInfoViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import RxSwift

final class CountryInfoViewModel: BaseViewModel {
    var name = ""
    let service = ServiceLayer.shared.countriesService
    var countryViewModel: CountryViewModel?
    
    func obtainCountry() {
        state.value = .loading
        service.obtainCountry(name: name,
                              completion: { [weak self] (countryData) in
                                guard let country = countryData.country else {
                                    self?.state.value = .failure(message: "Ошибка сервера!")
                                    return
                                }
                                self?.countryViewModel = CountryViewModel(country: country)
                                self?.state.value = .success
        }, errorClosure: { [weak self] (errorMessage) in
            self?.state.value = .failure(message: errorMessage)
        })
    }
}
