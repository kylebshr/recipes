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

    private let titleLabel = UILabel(font: .preferredFont(forTextStyle: .headline))
    private let ingregientCountLabel = UILabel(font: .preferredFont(forTextStyle: .callout))
    private let durationLabel = UILabel(font: .preferredFont(forTextStyle: .callout))
    private let interpunctView = UILabel(font: .preferredFont(forTextStyle: .callout))
    private let photoView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let numberFormatter = NumberFormatter()
        numberFormatter.generatesDecimalNumbers = false

        formatter.unitOptions = .naturalScale
        formatter.numberFormatter = numberFormatter

        photoView.backgroundColor = .systemGray5
        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = 4
        photoView.contentMode = .scaleAspectFill
        photoView.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
        photoView.setContentCompressionResistancePriority(.defaultLow - 1, for: .vertical)

        interpunctView.text = "·"

        let calloutStack = UIStackView(arrangedSubviews: [ingregientCountLabel, interpunctView, durationLabel])
        calloutStack.spacing = 4

        let labelStack = UIStackView(arrangedSubviews: [titleLabel, calloutStack])
        labelStack.alignment = .leading
        labelStack.axis = .vertical
        labelStack.spacing = 4

        let horizontalStack = UIStackView(arrangedSubviews: [labelStack, photoView])
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .top

        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalStack)

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            photoView.heightAnchor.constraint(equalToConstant: 60),
            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor),
        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(recipe: Recipe) {

        titleLabel.text = recipe.name
        ingregientCountLabel.text = "\(recipe.indredients.count) Ingredients"
        durationLabel.text = formatter.string(from: recipe.prepTime + recipe.cookTime)
        photoView.image = recipe.photo

    }
}
