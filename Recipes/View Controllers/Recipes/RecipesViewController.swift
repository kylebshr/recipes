//
//  RecipesViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit
import CoreServices

class RecipesViewController: UITableViewController, UITableViewDragDelegate {

    private let recipes: [Recipe]

    init(recipes: [Recipe]) {

        self.recipes = recipes

        super.init(style: .plain)

        tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "book"), selectedImage: nil)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Suggested Recipes"

        tableView.dragDelegate = self
        tableView.estimatedRowHeight = 100
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "identifier")

    }

    private func makeRecipeViewController(for indexPath: IndexPath) -> UIViewController {

        let recipe = recipes[indexPath.row]
        let viewController = RecipeViewController(recipe: recipe)

        return viewController

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]

        cell.display(recipe: recipe)

        return cell

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let viewController = makeRecipeViewController(for: indexPath)
        show(viewController, sender: self)

    }

    // MARK: - Drag and Drop

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        let recipe = recipes[indexPath.row]

        let instructionsData = recipe.instructions.data(using: .utf8)
        let instructionsProvider = NSItemProvider()

        instructionsProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(instructionsData, nil)
            return nil
        }

        let photoProvider = NSItemProvider(object: recipe.photo)

        return [
            UIDragItem(itemProvider: photoProvider),
            UIDragItem(itemProvider: instructionsProvider),
        ]

    }

    // MARK: - Context Menus

    // 1. Create a configuration with a menu
    // 2. Improve the menu with submenus
    // 3. Show detail for preview action
    // 4. Provide a preview view controller
    // 5. Improve the preview animation

}
