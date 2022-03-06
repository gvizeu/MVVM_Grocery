//
//  APIProtocols.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import Foundation
import Alamofire

protocol API {
    func requestObject<T: Decodable>(from route: GroceryAPIRouter,
                                     completion: (@escaping (_: Result<T, NetworkError>) -> Void))
}

protocol APIRouter {
    var path: String { get }
    func URLResquest() -> URLConvertible
}
