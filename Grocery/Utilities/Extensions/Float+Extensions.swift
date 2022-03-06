//
//  Float+Extensions.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation

extension Float {
    var asCurrency: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
