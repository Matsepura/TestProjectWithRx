//
//  AppCoordinator.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {    
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showMainController()
    }
    
    func showMainController() {
        let coordinator = MainControllerCoordinator()
        window.rootViewController = coordinator.navigationController!
        coordinator.start()
    }
}
