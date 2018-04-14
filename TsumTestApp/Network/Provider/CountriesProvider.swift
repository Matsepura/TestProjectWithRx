//
//  CountriesProvider.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Moya

enum CountriesProvider {
    case countriesList
    case countryInfo (name: String)
}

extension CountriesProvider: TargetType {
    var headers: [String: String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: PublicConstants.apiBase + PublicConstants.apiVersion)!
    }
    
    var path: String {
        switch self {
        case .countriesList:
            return "all"
        case .countryInfo (let name):
            return "name/" + name
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .countriesList, .countryInfo:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

// MARK: - Helpers

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
