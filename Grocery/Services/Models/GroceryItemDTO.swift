//
//  GroceryItemDTO.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import Foundation

struct GroceryItemDTO: Codable {
    let id: Int64
    let name, type: String
    let price: Float
}
