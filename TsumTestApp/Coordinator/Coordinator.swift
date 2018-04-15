//
//  Coordinator.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
    
    func stop()
    
    func navigate(from source: UIViewController,
                  to destination: UIViewController,
                  with identifier: String?,
                  and sender: AnyObject?)
}

extension Coordinator {
    func navigate(from source: UIViewController,
                  to destination: UIViewController,
                  with identifier: String?, and sender: AnyObject?) {
    }
    
    func stop() {
    }
}
