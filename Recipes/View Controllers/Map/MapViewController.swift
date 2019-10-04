//
//  MapViewController.swift
//  Recipes
//
//  Created by Kyle Bashour on 10/3/19.
//  Copyright © 2019 Kyle Bashour. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let mapView = MKMapView()

    override func loadView() {
        view = mapView
    }

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)

        tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), selectedImage: nil)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        let office = CLLocationCoordinate2D(latitude: 37.776545, longitude: -122.391885)
        let region = MKCoordinateRegion(center: office, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)

        let location = Location(coordinate: office)
        mapView.addAnnotation(location)

    }

}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let view = OfficeAnnotationView()

        if !view.interactions.contains(where: { $0 is UIContextMenuInteraction }) {
            let interaction = UIContextMenuInteraction(delegate: self)
            view.addInteraction(interaction)
        }

        return view

    }

}

extension MapViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let action = UIAction(title: "Whoa", handler: {_ in})
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [action])

        }

    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        guard let center = interaction.view?.center else { return nil }

        let view = OfficePreviewView(image: UIImage(named: "office")!)

        let target = UIPreviewTarget(container: mapView, center: center)

        let parameter = UIPreviewParameters()
        parameter.visiblePath = view.makeVisiblePath()

        return UITargetedPreview(view: view, parameters: parameter, target: target)
    }

}
