//
//  AnyViewModelConfigurable.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    func configure(with viewModel: Any)
}

protocol AnyViewModelConfigurable: ViewModelConfigurable {
    associatedtype ViewModel: Any
    
    func configure(with viewModel: ViewModel)
}

extension AnyViewModelConfigurable {
    func configure(with viewModel: Any) {
        guard let viewModel = viewModel as? ViewModel else {
            assertionFailure("Во View была передана некорректная ViewModel!")
            return
        }
        self.configure(with: viewModel)
    }
}
