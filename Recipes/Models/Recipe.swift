//
//  Recipe.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import Foundation
import UIKit

struct Recipe: MenuIdentifiable {

    let id: String = UUID().uuidString
    let name: String
    let prepTime: Measurement<UnitDuration>
    let cookTime: Measurement<UnitDuration>
    let indredients: [Ingredient]
    let photoName: String
    let instructions: String

}

extension Recipe {

    var photo: UIImage {
        UIImage(named: photoName)!
    }

}
