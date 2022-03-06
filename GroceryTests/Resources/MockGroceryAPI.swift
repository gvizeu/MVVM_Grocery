//
//  MockGroceryAPI.swift
//  GroceryTests
//
//  Created by Gonzalo Vizeu on 5/3/22.
//

import XCTest

@testable import Grocery
class MockGroceryAPI: XCTestCase, API {
    func requestObject<T>(from route: GroceryAPIRouter,
                          completion: @escaping ((Result<T, NetworkError>) -> Void)) where T: Decodable {
        let expectation = XCTestExpectation(description: "Getting itemo from json file")
        guard let path = Bundle.main.path(forResource: "groceryItems", ofType: "json") else {
            XCTFail("Could not find groceryItems")
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let quizesDTO = try JSONDecoder().decode(T.self, from: data)
            completion(.success(quizesDTO))
            expectation.fulfill()
        } catch {
            completion(.failure(.decodingError))
        }
        wait(for: [expectation], timeout: 10)
    }
}
