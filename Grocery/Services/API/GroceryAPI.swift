//
//  GroceryAPI.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case generic(code: Int?, description: String)
    case badRequest
    case decodingError
    case badURL
    case unableToFetchDataFromDB
}

final class GroceryAPI: API {

    lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        return Session(configuration: configuration)
    }()

    func requestObject<T>(from route: GroceryAPIRouter,
                          completion: @escaping ((Result<T, NetworkError>) -> Void)) where T: Decodable {

        sessionManager.request(route.URLResquest()).responseDecodable(of: T.self, completionHandler: { response in
            switch response.result {
            case .failure(let error):
                completion(Result.failure(.generic(code: error.responseCode, description: error.localizedDescription)))
            case .success(let value):
                completion(Result.success(value))
            }
        })
    }
}
