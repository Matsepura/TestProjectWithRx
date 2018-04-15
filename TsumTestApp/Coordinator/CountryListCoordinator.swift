//
//  CountryListCoordinator.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 15.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

class CountryListCoordinator: Coordinator {
    weak var viewController: CountriesListViewController?
    
    init() {
        viewController = CountriesListViewController.instantiate()
    }
    
    func start() {
        viewController?.coordinator = self
    }
    
    func showCountryInfo(by name: String) {
        let coordinator = CountryInfoCoordinator()
        guard let vc = coordinator.viewController else { return }
        coordinator.start()
        vc.viewModel.name = name
        vc.title = name
        viewController?.show(vc: vc)
    }
}
