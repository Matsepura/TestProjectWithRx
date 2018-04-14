//
//  Service.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    var networkClient: NetworkClient { get set }
    init(_ networkClient: NetworkClient)
}

class Service: NSObject, ServiceProtocol {
    var networkClient: NetworkClient
    
    required init(_ networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}
