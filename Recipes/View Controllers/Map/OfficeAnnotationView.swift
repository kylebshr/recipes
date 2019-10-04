//
//  OfficeView.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/3/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import MapKit

class OfficeAnnotationView: MKAnnotationView {

    override var annotation: MKAnnotation? {
        didSet {
            image = UIImage(named: "annotation")
            frame.size = image!.size
        }
    }

}
