//
//  String+Extension.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 6/3/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localized(_ args: CVarArg) -> String {
        return String(format: self.localized, args)
    }
}
