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
                name: "Carna Asada",
                prepTime: Measurement(value: 20, unit: .minutes),
                cookTime: Measurement(value: 25, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "carne"
            ),

            Recipe(
                name: "Cinnamon French Toast",
                prepTime: Measurement(value: 10, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "frenchtoast"
            ),

            Recipe(
                name: "Spinach Pappardelle",
                prepTime: Measurement(value: 40, unit: .minutes),
                cookTime: Measurement(value: 8, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pasta"
            ),

            Recipe(
                name: "Cauliflower Crust Pizza",
                prepTime: Measurement(value: 35, unit: .minutes),
                cookTime: Measurement(value: 35, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pizza"
            ),

            Recipe(
                name: "Salmon & Ratatouille",
                prepTime: Measurement(value: 40, unit: .minutes),
                cookTime: Measurement(value: 60, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "salmon"
            ),

            Recipe(
                name: "Baja Fish Tacos",
                prepTime: Measurement(value: 30, unit: .minutes),
                cookTime: Measurement(value: 25, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "tacos"
            ),

            Recipe(
                name: "Fancy Avocado Toast",
                prepTime: Measurement(value: 15, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "toast"
            ),

            Recipe(
                name: "Grilled Corn",
                prepTime: Measurement(value: 20, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "corn"
            ),

            Recipe(
                name: "Rosemary Lamb Chops",
                prepTime: Measurement(value: 30, unit: .minutes),
                cookTime: Measurement(value: 30, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "lamb"
            ),

            Recipe(
                name: "Acai Bowl",
                prepTime: Measurement(value: 35, unit: .minutes),
                cookTime: Measurement(value: 0, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "acai"
            ),

            Recipe(
                name: "Raspberry Popsicles",
                prepTime: Measurement(value: 10, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "popsicle"
            ),

            Recipe(
                name: "Meany Panini",
                prepTime: Measurement(value: 25, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "panini"
            ),

            Recipe(
                name: "Roasted Pork Chop & Potatoes",
                prepTime: Measurement(value: 25, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pork"
            ),

        ]

        let viewController = RecipesViewController(recipes: recipes)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        let mapViewController = MapViewController()

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController, mapViewController]

        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBarController.view.frame = view.bounds
        tabBarController.didMove(toParent: self)

    }
}
