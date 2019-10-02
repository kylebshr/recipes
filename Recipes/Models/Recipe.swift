//
//  Recipe.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import Foundation
import UIKit

struct Recipe {

    let id: NSUUID = NSUUID()

    let name: String
    let prepTime: Measurement<UnitDuration>
    let cookTime: Measurement<UnitDuration>
    let indredients: [Ingredient]
    let photoName: String

}

extension Recipe {
    var photo: UIImage { UIImage(named: photoName)! }
}
