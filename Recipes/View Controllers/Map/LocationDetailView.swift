//
//  LocationDetailViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/4/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class LocationDetailView: UIView {

    init(location: Location) {
        super.init(frame: .zero)

        backgroundColor = .systemBackground
        layer.cornerCurve = .continuous
        layer.cornerRadius = 20

        let titleLabel = UILabel(font: .preferredFont(forTextStyle: .headline))
        titleLabel.text = location.title

        let subtitleLabel = UILabel(font: .preferredFont(forTextStyle: .callout))
        subtitleLabel.text = location.subtitle

        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.cornerCurve = .continuous
        imageView.image = location.photo

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.setCustomSpacing(15, after: subtitleLabel)

        addSubview(stackView)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3.0 / 5)

        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
