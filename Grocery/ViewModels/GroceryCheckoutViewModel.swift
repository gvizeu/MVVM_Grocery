//
//  GroceryCheckoutViewModel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 28/2/22.
//

import Foundation

protocol GroceryCheckoutCoodinatorDelegate: AnyObject {
    func close()
}

protocol GroceryCheckoutViewModel {
    var model: GroceryItemListModel? { get }
    var totalAmount: Dynamic<String?> { get }

    func viewModel(from item: GroceryItem) -> GroceryItemViewModel?
    func close()
    func checkout()
}

class DefaultGroceryCheckoutViewModel: GroceryCheckoutViewModel {
    var totalAmount: Dynamic<String?>
    var coordinatorDelegate: GroceryCheckoutCoodinatorDelegate?
    var model: GroceryItemListModel?

    private var repository: GroceryItemListRepository

     init(repository: GroceryItemListRepository) {
        self.model = GroceryItemListModel(from: repository.fetchItemsFromDB() ?? [])
        self.repository = repository
        self.totalAmount = Dynamic(self.model?.totalAmount.asCurrency)
        prepareItems()
    }

    func viewModel(from item: GroceryItem) -> GroceryItemViewModel? {
        let item = Dynamic(item)
        item.bind { item in
            self.didUpdateAmount(item)
        }
        return DefaultGroceryItemViewModel(item: item)
    }

    func close() {
        coordinatorDelegate?.close()
    }

    func checkout() {
        GroseryDataStorage.eraseData()
        close()
    }

    fileprivate func didUpdateAmount(_ item: GroceryItem) {
        self.model?.itemsType.forEach({$0.updateTotalAmountForType()})
        self.totalAmount.value = self.model?.totalAmount.asCurrency
        self.repository.updateItem(item)
    }

    fileprivate func prepareItems() {
        model?.itemsType = model?.itemsType.filter({ itemType in
           itemType.items = itemType.items.filter({$0.amount > 0 })
           return itemType.items.count > 0
        }) ?? []
    }
}
