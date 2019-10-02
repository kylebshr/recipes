//
//  RecipeDetailCell.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/1/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

private let formatter = MeasurementFormatter()

class RecipeDetailCell: UITableViewCell {

    private let prepTimeLabel = UILabel(font: .preferredFont(forTextStyle: .body))
    private let cookTimeLabel = UILabel(font: .preferredFont(forTextStyle: .body))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        separatorInset = .zero

        let stackView = UIStackView(arrangedSubviews: [prepTimeLabel, cookTimeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(recipe: Recipe) {

        prepTimeLabel.text = "Prep time: \(formatter.string(from: recipe.prepTime))"
        cookTimeLabel.text = "Cook time: \(formatter.string(from: recipe.cookTime))"

    }

}
