//
//  CountriesListViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

final class CountriesListViewModel: BaseViewModel {
    let service = ServiceLayer.shared.countriesService
    let tableViewModel = CountriesListTableViewModel()
    
    func obtain() {
        state.value = .loading
        service.obtainCountriesList(completion: { [weak self] (countryData) in
            self?.setupViewModels(from: countryData.countries,
                            completion: { (viewModels) in
                                self?.tableViewModel.viewModels = viewModels
                                self?.state.value = .success
            })
        }, errorClosure: { [weak self] (errorMessage) in
            self?.state.value = .failure(message: errorMessage)
        })
    }
    
    private func setupViewModels(from countries: [CountryList],
                                 completion: @escaping ([CountryListViewModel]) -> ()) {
        DispatchQueue.global().async {
            var viewModels: [CountryListViewModel] = []
            countries.forEach({ viewModels.append(CountryListViewModel(country: $0)) })
            DispatchQueue.main.async {
                completion(viewModels)
            }
        }
    }
}
