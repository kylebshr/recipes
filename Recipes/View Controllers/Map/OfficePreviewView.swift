//
//  OfficePreviewView.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/3/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class OfficePreviewView: UIView {

    private let imageView = UIImageView()
    private let circleView = UIView()

    init(image: UIImage) {

        let size = CGSize(width: 80, height: 100)
        let frame = CGRect(origin: .zero, size: size)

        super.init(frame: frame)

        backgroundColor = .clear

        addSubview(imageView)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40

        addSubview(circleView)
        circleView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7688797712, alpha: 1)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = 6

        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),

            circleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor),

        ])

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeVisiblePath() -> UIBezierPath {

        layoutIfNeeded()

        let circlePath = UIBezierPath(ovalIn: imageView.frame)
        let dotPath = UIBezierPath(ovalIn: circleView.frame)
        circlePath.append(dotPath)

        return circlePath
        
    }
}
