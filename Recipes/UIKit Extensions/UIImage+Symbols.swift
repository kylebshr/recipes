//
//  UIImage+Symbols.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/7/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

extension UIImage {

    enum Symbol: String {

        case book = "book"
        case share = "square.and.arrow.up"
        case plus = "plus"
        case thumbsDown = "hand.thumbsdown"
        case heart = "heart"
        case ellipsis = "ellipsis.circle.fill"
        case close = "xmark.circle.fill"
        case map = "map"

    }

    convenience init(symbol: Symbol) {
        self.init(systemName: symbol.rawValue)!
    }

}
