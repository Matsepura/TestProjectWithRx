//
//  MainViewController.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 15.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

final class MainViewController: BaseViewController {
    var coordinator: MainControllerCoordinator?
    
    @IBAction func startAction(_ sender: Any) {
        coordinator?.showCountryList()
    }
}
