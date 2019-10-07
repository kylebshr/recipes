//
//  ViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

private let instructions = """
Preheat oven to 375º. Prepare vegetables by gently washing, taking care not to bruise. Thinly slice, and season with salt and pepper. Heat a skillet over medium heat, and sear the vegetables and protein. I don't really know how to write a recipe. Following, is some Jeff Ipsum.

What do they got in there? King Kong? God creates dinosaurs. God destroys dinosaurs. God creates Man. Man destroys God. Man creates Dinosaurs. They're using our own satellites against us. And the clock is ticking. Hey, take a look at the earthlings. Goodbye!

Life finds a way. They're using our own satellites against us. And the clock is ticking. You know what? It is beets. I've crashed into a beet truck. Must go faster... go, go, go, go, go! I gave it a cold? I gave it a virus. A computer virus. Is this my espresso machine? Wh-what is-h-how did you get my espresso machine?
"""

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let recipes = [
            Recipe(
                name: "Carna Asada",
                prepTime: Measurement(value: 20, unit: .minutes),
                cookTime: Measurement(value: 25, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "carne",
                instructions: instructions
            ),

            Recipe(
                name: "Cinnamon French Toast",
                prepTime: Measurement(value: 10, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "frenchtoast",
                instructions: instructions
            ),

            Recipe(
                name: "Spinach Pappardelle",
                prepTime: Measurement(value: 40, unit: .minutes),
                cookTime: Measurement(value: 8, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pasta",
                instructions: instructions
            ),

            Recipe(
                name: "Cauliflower Crust Pizza",
                prepTime: Measurement(value: 35, unit: .minutes),
                cookTime: Measurement(value: 35, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pizza",
                instructions: instructions
            ),

            Recipe(
                name: "Salmon & Ratatouille",
                prepTime: Measurement(value: 40, unit: .minutes),
                cookTime: Measurement(value: 60, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "salmon",
                instructions: instructions
            ),

            Recipe(
                name: "Baja Fish Tacos",
                prepTime: Measurement(value: 30, unit: .minutes),
                cookTime: Measurement(value: 25, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "tacos",
                instructions: instructions
            ),

            Recipe(
                name: "Fancy Avocado Toast",
                prepTime: Measurement(value: 15, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "toast",
                instructions: instructions
            ),

            Recipe(
                name: "Grilled Corn",
                prepTime: Measurement(value: 20, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "corn",
                instructions: instructions
            ),

            Recipe(
                name: "Rosemary Lamb Chops",
                prepTime: Measurement(value: 30, unit: .minutes),
                cookTime: Measurement(value: 30, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "lamb",
                instructions: instructions
            ),

            Recipe(
                name: "Acai Bowl",
                prepTime: Measurement(value: 35, unit: .minutes),
                cookTime: Measurement(value: 0, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "acai",
                instructions: instructions
            ),

            Recipe(
                name: "Raspberry Popsicles",
                prepTime: Measurement(value: 10, unit: .minutes),
                cookTime: Measurement(value: 10, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "popsicle",
                instructions: instructions
            ),

            Recipe(
                name: "Meany Panini",
                prepTime: Measurement(value: 25, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "panini",
                instructions: instructions
            ),

            Recipe(
                name: "Roasted Pork Chop & Potatoes",
                prepTime: Measurement(value: 25, unit: .minutes),
                cookTime: Measurement(value: 20, unit: .minutes),
                indredients: [.butter, .angelHair, .chicken, .broccoli, .butter, .angelHair, .chicken, .broccoli],
                photoName: "pork",
                instructions: instructions
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
