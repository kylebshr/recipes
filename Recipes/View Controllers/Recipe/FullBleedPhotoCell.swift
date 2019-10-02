//
//  FullBleedPhotoCell.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/1/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class FullBleedPhotoCell: UITableViewCell {

    private let photoView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        separatorInset = .zero

        photoView.clipsToBounds = true
        photoView.contentMode = .scaleAspectFill
        photoView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(photoView)

        let heightConstraint = photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 3.0 / 5)
        heightConstraint.priority = .required - 1

        NSLayoutConstraint.activate([
            heightConstraint,
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(photo: UIImage) {

        photoView.image = photo

    }

}
