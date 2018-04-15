//
//  CountryInfoCoordinator.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 15.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

class CountryInfoCoordinator: Coordinator {
    weak var viewController: CountryInfoViewController?
    
    init() {
        viewController = CountryInfoViewController.instantiate()
    }
    
    func start() {
        viewController?.coordinator = self
    }
    
    func stop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
