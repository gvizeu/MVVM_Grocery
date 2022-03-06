//
//  GroceryItemListModel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 2/3/22.
//

import Foundation

class GroceryItemListModel {
    var itemsType: [GroceryItemTypeModel]
    var totalAmount: Float {
        self.itemsType.map({ $0.totalAmountForType.value }).reduce(Float(0), +)
    }

    init(from model: [GroceryItem]) {
        self.itemsType = [GroceryItemTypeModel]()
        fillData(from: model)
        self.itemsType = self.itemsType.sorted(by: { $0.name < $1.name })
    }

     private func fillData(from model: [GroceryItem]) {

        var dict: [String: Int] = [String: Int]()
        model.forEach { item in
            if let type = item.type {
                if let count = dict[type], count > 0 {
                    dict[type] = count + 1
                } else {
                    dict[type] = 1
                }
            }
        }
        dict.keys.forEach { keyValue in
            let list: [GroceryItem] = model.filter({ $0.type == keyValue})
            let itemType = GroceryItemTypeModel(name: keyValue, items: list)
            itemsType.append(itemType)
        }
    }
}
