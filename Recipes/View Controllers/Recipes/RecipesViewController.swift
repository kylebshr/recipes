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

    // MARK: Table View

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

    // MARK: Drag and Drop

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
}

// MARK: - Context Menus

extension RecipesViewController {

    // 1. Create a configuration with a menu
    //    - Actions for sharing, shopping list, dislike

    // 2. Improve the menu with submenus
    //    - Actions for saving to lists
    //    - Submenu for those actions
    //    - Inline menu when appropiate

    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let lists = ["Favorites", "Deserts"]
        let recipe = recipes[indexPath.row]

        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in

            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("Share \(recipe)")
            }

            let shareMenu = UIMenu(title: "", options: .displayInline, children: [share])

            let saveIngredients = UIAction(title: "Add to Shopping List", image: UIImage(systemName: "plus")) { _ in
                print("Add ingredients")
            }

            let dislike = UIAction(title: "Dislike", image: UIImage(systemName: "hand.thumbsdown"), attributes: .destructive) { _ in
                print("Dislike")
            }

            let listActions = lists.map {
                UIAction(title: "Save to \($0)") {
                    print("Save to list \($0)")
                }
            }

            let saveMenuStyle: UIMenu.Options = listActions.count > 2 ? [] : .displayInline
            let saveMenu = UIMenu(title: "Save Recipe...", image: UIImage(systemName: "heart"), options: saveMenuStyle, children: listActions)

            let menu = UIMenu(title: "", children: [saveIngredients, dislike, saveMenu, shareMenu])
            return menu

        })

        return configuration

    }

    // 3. Show detail on preview action

    // 4. Provide a preview view controller
    //    - Start with detail view controller
    //    - Walk through `RecipePreviewViewController`
    //    - Use `previewProvider`

    // 5. Polish preview animation
    //    - Discuss UITargetedPreview
    //    - Add targeted preview for image

    // 6. Add drag integration

}
