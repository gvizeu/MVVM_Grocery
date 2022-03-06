//
//  GroceryItemTypeModel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation

class GroceryItemTypeModel {
    let name: String
    var items: [GroceryItem]
    var totalAmountForType: Dynamic<Float>

    init(name: String, items: [GroceryItem]) {
        self.name = name
        self.items = items.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
        let sum = items.map({ ($0.price * Float($0.amount)) }).reduce(0.0, +)
        self.totalAmountForType = Dynamic(sum)
    }

    func addItem(_ item: GroceryItem) {
        self.items.append(item)
    }

    func updateTotalAmountForType() {
        self.totalAmountForType.value = getTotalAmount()
    }

    func getTotalAmount() -> Float {
        return items.map({ ($0.price * Float($0.amount)) }).reduce(0.0, +)
    }
}
