//
//  RecipeViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/1/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {

    private let recipe: Recipe

    init(recipe: Recipe) {

        self.recipe = recipe

        super.init(style: .insetGrouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsSelection = false

        navigationItem.title = recipe.name
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style: .plain, target: self, action: #selector(showMenu))

    }

    @objc private func showMenu(sender: UIBarButtonItem?) {

        let addIngredients = UIAlertAction(title: "Add to Shopping List", style: .default, handler: nil)
        let save = UIAlertAction(title: "Save Recipe...", style: .default, handler: nil)
        let share = UIAlertAction(title: "Share", style: .default, handler: nil)
        let dislike = UIAlertAction(title: "Dislike", style: .destructive, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.barButtonItem = sender
        [addIngredients, save, share, dislike, cancel].forEach(actionSheet.addAction)

        present(actionSheet, animated: true)

    }

    // MARK: - UITableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0: return 2
        case 1: return recipe.indredients.count
        case 2: return 1
        default: fatalError("Unexpected section")
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {

        case 0:

            if indexPath.row == 0 {

                let cell = FullBleedPhotoCell()
                cell.display(photo: recipe.photo)
                return cell

            } else {

                let cell = RecipeDetailCell()
                cell.display(recipe: recipe)
                return cell

            }

        case 1:

            let ingredient = recipe.indredients[indexPath.row]
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = ingredient.name
            cell.detailTextLabel?.text = "\(Int(ingredient.quantity)) \(ingredient.unit)"
            return cell

        case 2:

            let cell = UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = recipe.instructions
            return cell

        default:

            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "Ingredients"
        case 2: return "Instructions"
        default: return nil
        }
    }
}
