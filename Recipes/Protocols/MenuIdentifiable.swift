//
//  MenuIdentifiable.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/7/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import Foundation
import UIKit

protocol MenuIdentifiable {

    var id: String { get }

}

extension MenuIdentifiable {

    var menuID: NSString {
        NSString(string: id)
    }

    func isReferenced(by configuration: UIContextMenuConfiguration) -> Bool {
        return menuID == configuration.identifier as? NSString
    }

}
