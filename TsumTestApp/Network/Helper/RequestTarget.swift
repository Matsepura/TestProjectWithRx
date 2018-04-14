//
//  RequestTarget.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 14.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Alamofire
import Foundation

struct RequestTarget: CustomStringConvertible {
    var url: URL
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parameters: [String: Any]?
    var headers: [String: String]?
    
    var description: String {
        return "\n -url: \(url)\n -Method: \(method)\n -Encoding:" +
        " \(encoding)\n -Parameters: \(String(describing: parameters))\n -Headers: \(String(describing: headers))\n"
    }
}
