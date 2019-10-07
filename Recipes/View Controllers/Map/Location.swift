//
//  Location.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/3/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import MapKit

class Location: NSObject, MKAnnotation, MenuIdentifiable {

    let id: String = UUID().uuidString
    let title: String? = "Lyft HQ"
    let subtitle: String? = "185 Berry St."
    let coordinate = CLLocationCoordinate2D(latitude: 37.776545, longitude: -122.391885)
    let photo = UIImage(named: "office")!

}
