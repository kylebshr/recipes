//
//  Ingredient.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import Foundation

struct Ingredient {

    let name: String
    let quantity: Double
    let unit: String

}

extension Ingredient {
    static let broccoli = Ingredient(name: "Brocolli", quantity: 1, unit: "head")
    static let angelHair = Ingredient(name: "Angel Hair", quantity: 2, unit: "lbs")
    static let butter = Ingredient(name: "Butter", quantity: 2, unit: "tbsp")
    static let chicken = Ingredient(name: "Chicken Thigh", quantity: 4, unit: "thighs")
}
