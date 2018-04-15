//
//  AppDelegate.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
