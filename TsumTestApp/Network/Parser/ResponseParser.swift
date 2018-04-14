//
//  ResponseParser.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

struct ResponseParser {
    static func parse<Object>(parsingData data: Data,
                              objectType: Object.Type,
                              completion: (Object) -> Void,
                              failure: ErrorClosure?) where Object: Decodable {
        
        BaseResponse<Object>.parseFromJSON(data, completion: { (baseResponse) in
            if let failureDetailText = baseResponse.errorResponseInfo?.description {
                failure?(failureDetailText)
                return
            }
            
            guard let responseObject = baseResponse.object else {
                failure?("Ошибка сериализации данных с сервера")
                return
            }
            completion(responseObject)
        }, errorClosure: failure)
    }
}

private struct BaseResponse<T: Decodable>: Decodable, JSONCodable {
    let errorResponseInfo: ErrorResponseInfo?
    let object: T?
    
    enum CodingKeys: String, CodingKey {
        case data, error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        errorResponseInfo = try container.decodeIfPresent(ErrorResponseInfo.self, forKey: .error)
        object = try container.decodeIfPresent(T.self, forKey: .data)
    }
}
