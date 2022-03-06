//
//  GroceryItemViewModel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation

protocol GroceryItemViewModel {
    var itemName: String { get }
    var itemPrice: String { get }
    var itemID: Int64 { get }
    var itemamount: Dynamic<String> { get }

    func addItem()
    func removeItem()
}

class DefaultGroceryItemViewModel: GroceryItemViewModel {

    var itemName: String
    var itemPrice: String
    var itemamount: Dynamic<String>
    var itemID: Int64

    fileprivate var item: Dynamic<GroceryItem>

    init(item: Dynamic<GroceryItem>) {
        self.item = item
        self.itemName = item.value.name ?? ""
        self.itemPrice = item.value.price.asCurrency
        self.itemamount = Dynamic("\(item.value.amount)")
        self.itemID = item.value.id
    }

    func addItem() {
        let amount = (Int(itemamount.value) ?? 0) + 1
        itemamount.value = "\(amount)"
        item.value.amount = Int64(amount)
        item.value = item.value
    }

    func removeItem() {
        if let value = Int(itemamount.value), value > 0 {
            itemamount.value = "\(value - 1)"
            item.value.amount = Int64(value - 1)
            item.value = item.value
        }
    }
}
