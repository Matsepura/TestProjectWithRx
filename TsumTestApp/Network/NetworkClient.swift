//
//  NetworkClient.swift
//  TsumTestApp
//
//  Created by Semen Matsepura on 13.04.2018.
//  Copyright © 2018 Semen Matsepura. All rights reserved.
//

import Foundation
import Moya

struct CancellableRequest {
    let request: Cancellable
    let requestId: String
}

final class NetworkClient {
    private enum Constants {
        static let serverError = "Ошибка сервера!\nОбратитесь в поддержку"
    }
    
    internal let operationQueue = OperationQueue()
    let provider = MoyaProvider<MultiTarget>()
    var requests: [CancellableRequest] = []
    
    func request(target: MultiTarget, success successCallback: ((Response) -> Void)? = nil,
                 error errorCallback: ((Swift.Error) -> Void)? = nil,
                 failure failureCallback: ((MoyaError) -> Void)? = nil) -> Cancellable {
        // Присваеваем идентификатор запросу, он уникален
        // По идентификатору можно убирать элемент, когда запрос выполнится
        let requestId = UUID().uuidString
        
        let request = provider.request(target) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            strongSelf.requests = strongSelf.requests.filter({ $0.requestId != requestId })
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback?(response)
                } else {
                    let error = NSError(domain: "server error",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: Constants.serverError])
                    DispatchQueue.main.async {
                        errorCallback?(error)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    failureCallback?(error)
                }
            }
        }
        requests.append(CancellableRequest(request: request, requestId: requestId))
        return request
    }
    
    func cancel(_ request: Cancellable) {
        request.cancel()
        requests = requests.filter({ !$0.request.isCancelled })
    }
    
    func cancelAllRequests() {
        requests.forEach({ $0.request.cancel() })
        requests.removeAll()
    }
}

typealias JSONRequestable = (Encodable & JSONCodable)
typealias JSONResponsable = (Decodable & JSONCodable)

extension NetworkClient {
    
    /// Метод, инкапсулирующий отправку request'a. Его плюс в том, что он не знает логику парсинга.
    /// Просто отправляет нужный запрос и отдает response.
    /// Вся основная работа проводится в потоке с Utility QoS
    /// success - выдается НЕ в главном потоке для дальнейшего парсинга, а failure выдаются в главном потоке.
    ///
    /// - Parameters:
    ///   - target: блок, принимающий сериализованный JSON Data и возвращающий объект типа TargetType
    ///   - successClosure: Ответ от сервера (response)
    ///   - failureClosure: блок ошибки со строкой в человекочитаемом формате
    func performRequest(target: MultiTarget,
                        successClosure: MoyaResponseClosure?,
                        failureClosure: ErrorClosure?) {
        
        DispatchQueue.global(qos: .utility).async {
            _ = self.request(target: target, success: { (response) in
                successClosure?(response)
            }, error: { (error) in
                DispatchQueue.main.async {
                    failureClosure?(error.localizedDescription)
                }
            }, failure: { (moyaError) in
                DispatchQueue.main.async {
                    failureClosure?(moyaError.localizedDescription)
                }
            })
        }
    }
    
    /// Метод сериализует данные для отправки на сервер. В случае ошибки вызывает failure на ГЛАВНОМ потоке.
    func createJSONBody<NetworkRequest: JSONRequestable>(with requestBody: NetworkRequest,
                                                         completion: @escaping DataClosure,
                                                         failure: ErrorClosure?) {
        DispatchQueue.global(qos: .utility).async {
            requestBody.createJSON(completion: completion, errorClosure: { (errorString) in
                DispatchQueue.main.async {
                    failure?(errorString)
                }
            })
        }
    }
    
    /// Метод, инкапсулирующий логику сериализации из/в JSON и маппирующий NetworkResponse в готовые
    /// объекты. Вся основная работа проводится в потоке с Utility QoS, ответы в блоках
    /// success и failure выдаются в главном потоке.
    ///
    /// - Parameters:
    ///   - target: блок, принимающий сериализованный JSON Data и возвращающий объект типа TargetType
    ///   - requestBody: объект,имплементирующий Encodable и JSONCodable,
    ///                 который будет сериализован в JSON.
    ///   - responseType: ожидаемый тип объекта, имплементирующий Decodable и JSONCodable, \
    ///                 который передаётся в блок succuss.
    ///   - successClosure: Tuple из объекта типа responseType и опциональный usermessage с сервера
    ///   - failureClosure: блок ошибки со строкой в человекочитаемом формате
    func requestWithBody<NetworkRequest: JSONRequestable, NetworkResponse: JSONResponsable>(
        target: @escaping (Data) -> MultiTarget,
        requestBody: NetworkRequest,
        responseType: NetworkResponse.Type = NetworkResponse.self,
        successClosure: ((NetworkResponse) -> Void)?,
        failureClosure: ErrorClosure?) {
        
        createJSONBody(with: requestBody, completion: { [weak self] (jsonData) in
            self?.performRequest(target: target(jsonData), successClosure: { (response) in
                do {
                    let object = try response.map(NetworkResponse.self)
                    DispatchQueue.main.async {
                        successClosure?(object)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        failureClosure?(error.localizedDescription)
                    }
                }
            }, failureClosure: failureClosure)
            }, failure: failureClosure)
    }
    
    /// Метод, инкапсулирующий логику сериализации из/в JSON и маппирующий NetworkResponse в готовые
    /// объекты. Вся основная работа проводится в потоке с Utility QoS, ответы в блоках
    /// success и failure выдаются в главном потоке.
    ///
    /// - Parameters:
    ///   - target: блок, принимающий сериализованный JSON Data и возвращающий объект типа TargetType
    ///   - responseType: ожидаемый тип объекта, имплементирующий Decodable и JSONCodable, \
    ///                 который передаётся в блок success
    ///   - successClosure: Tuple из объекта типа responseType и опциональный usermessage с сервера
    ///   - failureClosure: блок ошибки со строкой в человекочитаемом формате
    func requestWithoutBody<NetworkResponse: JSONResponsable>(
        target: MultiTarget,
        responseType: NetworkResponse.Type = NetworkResponse.self,
        successClosure: ((NetworkResponse) -> Void)?,
        failureClosure: ErrorClosure?) {
        performRequest(target: target, successClosure: { (response) in
            do {
                let object = try response.map(NetworkResponse.self)
                DispatchQueue.main.async {
                    successClosure?(object)
                }
            } catch let error {
                DispatchQueue.main.async {
                    failureClosure?(error.localizedDescription)
                }
            }
        }, failureClosure: failureClosure)
    }
}
