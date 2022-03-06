//
//  GroceryAPIRouter.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation
import Alamofire

enum GroceryAPIRouter: APIRouter {

    fileprivate var baseURL: String { "https://raw.githubusercontent.com" }

    case groceryItems

    var method: HTTPMethod {
        switch self {
        case .groceryItems: return .get
        }
    }

    var path: String {
        switch self {
        case .groceryItems: return "/bmdevel/MobileCodeChallengeResources/main/groceryProducts.json"
        }
    }

    func URLResquest() -> URLConvertible {
        do {
            let url = try baseURL.asURL()
            return url.appendingPathComponent(path)
        } catch {
            fatalError("URL fro request invalid")
        }
    }
}
