//
//  LocationDetailViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/4/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class LocationDetailView: UIView {

    private let close: () -> Void

    init(location: Location, close: @escaping () -> Void) {

        self.close = close

        super.init(frame: .zero)

        backgroundColor = .systemBackground
        layer.cornerCurve = .continuous
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowOffset = .zero

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
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.setCustomSpacing(15, after: subtitleLabel)

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.addTarget(self, action: #selector(handleCloseTap), for: .primaryActionTriggered)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        addSubview(closeButton)

        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),

            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3.0 / 5),

            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 1),

        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleCloseTap() {
        close()
    }

}
