//
//  ErrorResponseInfo.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

struct ErrorResponseInfo: Decodable, JSONCodable {
    let code: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case code, description
    }
}
