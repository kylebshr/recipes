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

    private func makePhotoPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        guard let index = recipes.index(for: configuration) else {
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

        let configuration = UIContextMenuConfiguration(identifier: recipe.menuID, previewProvider: {

            return RecipePreviewViewController(photo: recipe.photo)

        }, actionProvider: { _ in

            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("Share")
            }

            let shareMenu = UIMenu(title: "", options: .displayInline, children: [share])

            let saveIngredients = UIAction(title: "Add to Shopping List", image: UIImage(systemName: "plus")) { _ in
                print("Add ingredients")
            }

            let dislike = UIAction(title: "Dislike", image: UIImage(systemName: "hand.thumbsdown"), attributes: .destructive) { _ in
                print("Dislike")
            }

            let lists = ["Favorites", "Deserts"].map {
                UIAction(title: $0, handler: { _ in })
            }

            let save = UIMenu(title: "Save Recipe...", image: UIImage(systemName: "heart"), children: lists)

            let menu = UIMenu(title: "", children: [saveIngredients, save, dislike, shareMenu])
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

        guard let recipe = recipes.item(for: configuration) else {
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
