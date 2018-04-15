//
//  MainControllerCoordinator.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 15.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

class MainControllerCoordinator: Coordinator {
    weak var viewController: MainViewController?
    weak var navigationController: UINavigationController?
    
    init() {
        viewController = MainViewController.instantiate()
        navigationController = UINavigationController(rootViewController: viewController!)
    }
    
    func start() {
        viewController?.coordinator = self
    }
    
    func showCountryList() {
        let coordinator = CountryListCoordinator()
        guard let vc = coordinator.viewController else { return }
        coordinator.start()
        viewController?.show(vc: vc)
    }
}
