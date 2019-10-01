//
//  ViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let recipes = [
            Recipe(
                name: "Fish Tacos",
                prepTime: Measurement(value: 30, unit: .minutes),
                cookTime: Measurement(value: 30, unit: .minutes),
                indredients: [],
                photoName: []
            ),
        ]

        let viewController = RecipesViewController(recipes: recipes)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.view.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        navigationController.view.frame = view.bounds
        navigationController.didMove(toParent: self)

    }
}
