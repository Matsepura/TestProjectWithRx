//
//  CommonAliases.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import Moya

// Базовый тип ViewModel
typealias ViewModel = Any

// Пустой клоужер
typealias VoidClosure = () -> Void

// Клоужер, принимающий текст
typealias TextClosure = (String) -> Void

// Клоужер с текстом ошибки
typealias ErrorClosure = (String) -> Void

// Клоужер с ошибкой
typealias FailureClosure = (Error) -> Void

//// Клоужер с базовым стейтом PresentationModel
//typealias BaseViewModelStateClosure = (BaseViewModel.BaseViewModelStates) -> Void

// Пустой клоужер
typealias MoyaResponseClosure = ((Response) -> Void)

typealias DataClosure = (Data) -> Void

typealias CellMapper = ((ViewModel) -> (UITableViewCell.Type))
