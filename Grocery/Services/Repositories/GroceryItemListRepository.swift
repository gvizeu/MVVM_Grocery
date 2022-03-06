//
//  GroceryItemListRepository.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 5/3/22.
//

import Foundation

protocol GroceryItemListRepository {
    init(session: API, dataStorage: GroseryStorage)
    func fetchItems(completion: @escaping (_: Result<[GroceryItem], NetworkError>) -> Void)
    func fetchItemsFromDB() -> [GroceryItem]?
    func updateItem(_ item: GroceryItem)
}

final class DefaultGroceryItemListRepository: GroceryItemListRepository {

    private let session: API
    private let dataStorage: GroseryStorage

    init(session: API, dataStorage: GroseryStorage) {
        self.session = session
        self.dataStorage = dataStorage
    }
    func fetchItems(completion: @escaping (_: Result<[GroceryItem], NetworkError>) -> Void) {
        session.requestObject(from: .groceryItems) { [self] (result: Result<[GroceryItemDTO], NetworkError>) in
            switch result {
            case .success(let itemsDTO):
                itemsDTO.forEach { item in
                    dataStorage.addItem(name: item.name,
                                               id: item.id,
                                               price: item.price,
                                               type: item.type)
                }
                if let items = dataStorage.fetchGroceryItems() {
                    completion(.success(items))
                } else {
                    completion(.failure(.unableToFetchDataFromDB))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchItemsFromDB() -> [GroceryItem]? {
        dataStorage.fetchGroceryItems()
    }

    func updateItem(_ item: GroceryItem) {
        dataStorage.updateItem(item)
    }
}
