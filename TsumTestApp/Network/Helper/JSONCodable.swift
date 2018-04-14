//
//  JSONCodable.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation

protocol JSONCodable { }

extension JSONCodable where Self: Encodable {
    func createJSON(completion: (Data) -> Void, errorClosure: ErrorClosure?) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            completion(jsonData)
        } catch {
            print("ERROR: \(#function)")
            errorClosure?("Ошибка создания данных для отправки на сервер")
        }
    }
}

extension JSONCodable where Self: Decodable {
    static func parseFromJSON(_ jsonData: Data, completion: (Self) -> Void, errorClosure: ErrorClosure?) {
        let decoder = JSONDecoder()
        do {
            let container = try decoder.decode(Self.self, from: jsonData)
            completion(container)
        } catch let error as NSError {
            print("ERROR: \(#function)")
            errorClosure?("Ошибка сериализации данных с сервера\n\(error.localizedDescription)")
        }
    }
}
