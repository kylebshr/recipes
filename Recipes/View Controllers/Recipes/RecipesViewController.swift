//
//  RecipesViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {

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

        navigationItem.title = "Recipes"

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

    // MARK: - Context Menus

    private func makePhotoPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        guard let index = recipes.firstIndex(where: { $0.id == configuration.identifier as! NSUUID }) else {
            return nil
        }

        guard let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? RecipeCell else {
            return nil
        }

        let preview = UITargetedPreview(view: cell.highlightPreview)

        return preview

    }

    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let recipe = recipes[indexPath.row]

        let configuration = UIContextMenuConfiguration(identifier: recipe.id, previewProvider: {

            return RecipePreviewViewController(photo: recipe.photo)

        }, actionProvider: { _ in

            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("Share")
            }

            let saveIngredients = UIAction(title: "Add to Shopping List", image: UIImage(systemName: "plus")) { _ in
                print("Add ingredients")
            }

            let lists = ["Favorites", "Deserts"].map {
                UIAction(title: $0, handler: { _ in })
            }

            let save = UIMenu(title: "Save Recipe...", image: UIImage(systemName: "heart"), children: lists)

            let menu = UIMenu(title: "", children: [saveIngredients, save, share])
            return menu

        })

        return configuration

    }

    override func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makePhotoPreview(for: configuration)
    }

    override func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makePhotoPreview(for: configuration)
    }

    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {

        guard let recipe = recipes.first(where: { $0.id == configuration.identifier as! NSUUID }) else {
            return
        }

        let viewController = RecipeViewController(recipe: recipe)

        animator.addCompletion { [weak self] in

            guard let self = self else {
                return
            }

            self.show(viewController, sender: self)

        }
    }
}
