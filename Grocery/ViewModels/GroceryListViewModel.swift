//
//  GroceryListViewModel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation
import UIKit

protocol GroceryListCoordinatorDelegate: AnyObject {
    func checkOut()
}

protocol GroceryListViewModel {
    var model: Dynamic<GroceryItemListModel> { get }
    var isCartFill: Dynamic<Bool> { get }

    func fetchData()
    func viewModel(from item: GroceryItem) -> GroceryItemViewModel?
    func didTapOncheckout()
}

class DefaultGroceryListViewModel: GroceryListViewModel {
    var isCartFill: Dynamic<Bool>
    var model: Dynamic<GroceryItemListModel>
    var coordinatorDelegate: GroceryListCoordinatorDelegate?

    private var repository: GroceryItemListRepository

    init(repository: GroceryItemListRepository) {
        self.repository = repository
        self.model =  Dynamic(GroceryItemListModel(from: repository.fetchItemsFromDB() ?? []))
        self.isCartFill = Dynamic(model.value.totalAmount > 0)
    }

    func fetchData() {
        if canFetchDataFromDB() {
            self.model.value = GroceryItemListModel(from: repository.fetchItemsFromDB() ?? [])
        } else {
            refreshData()
        }
    }

    func viewModel(from item: GroceryItem) -> GroceryItemViewModel? {
        let item = Dynamic(item)
        item.bind { self.willUpdateAmoutForType(item: $0) }
        return DefaultGroceryItemViewModel(item: item)
    }

    fileprivate func willUpdateAmoutForType(item: GroceryItem) {
        self.model.value.itemsType.forEach({$0.updateTotalAmountForType()})
        self.isCartFill.value = model.value.totalAmount > 0
        repository.updateItem(item)
    }

    fileprivate func canFetchDataFromDB() -> Bool {
        if let item = repository.fetchItemsFromDB()?.first {
            if let lastRefreshDate = item.timestamp,
               let diff = Calendar.current.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour,
               diff > 24 {
                GroseryDataStorage.eraseData()
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    fileprivate func refreshData() {

        repository.fetchItems { result in
            switch result {
            case .success(let items):
                self.model.value = GroceryItemListModel(from: items)
                self.isCartFill.value = self.model.value.totalAmount > 0
            case .failure:
                self.model.value = GroceryItemListModel(from: [])
            }
        }
    }

    func didTapOncheckout() {
        coordinatorDelegate?.checkOut()
    }
}
