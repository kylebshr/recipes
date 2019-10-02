//
//  RecipePreviewViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/1/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit

class RecipePreviewViewController: UIViewController {

    private let photoView = UIImageView()

    override func loadView() {
        photoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = photoView
    }

    init(photo: UIImage) {

        super.init(nibName: nil, bundle: nil)

        photoView.image = photo
        preferredContentSize = photo.size

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
