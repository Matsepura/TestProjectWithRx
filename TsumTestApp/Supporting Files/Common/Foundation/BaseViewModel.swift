//
//  BaseViewModel.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    enum States {
        case zero
        case loading
        case failure (message: String)
        case success
    }
    
    let state: Variable<States> = Variable(.zero)
}
