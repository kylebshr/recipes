//
//  RecipeCell.swift
//  Recipes
//
//  Created by Kyle Bashour on 9/30/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

private let formatter = MeasurementFormatter()

class RecipeCell: UITableViewCell {

    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 20))
    private let ingregientCountLabel = UILabel(font: .boldSystemFont(ofSize: 13))
    private let durationLabel = UILabel(font: .boldSystemFont(ofSize: 13))
    private let photoView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        photoView.backgroundColor = .systemGray5
        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = 4

        let calloutStack = UIStackView(arrangedSubviews: [ingregientCountLabel, durationLabel])
        calloutStack.axis = .vertical

        let labelStack = UIStackView(arrangedSubviews: [titleLabel, calloutStack])
        labelStack.alignment = .leading
        labelStack.axis = .vertical
        labelStack.spacing = 4

        let horizontalStack = UIStackView(arrangedSubviews: [labelStack, photoView])
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .fill

        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor),
        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(recipe: Recipe) {

        titleLabel.text = recipe.name
        ingregientCountLabel.text = "\(recipe.indredients.count) Ingredient"
        durationLabel.text = formatter.string(from: recipe.prepTime + recipe.cookTime)
        photoView.image = recipe.photoName.first.flatMap { UIImage(named: $0) }

    }
}
