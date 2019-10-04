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

        let office = Location()
        let region = MKCoordinateRegion(center: office.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
        mapView.addAnnotation(office)
        mapView.delegate = self

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

        guard let annotationView = interaction.view as? OfficeAnnotationView else {
            return nil
        }

        guard let location = annotationView.annotation as? Location else {
            return nil
        }

        let preview = OfficePreviewView(image: location.photo)

        let target = UIPreviewTarget(container: mapView, center: annotationView.center)

        let parameter = UIPreviewParameters()
        parameter.visiblePath = preview.makeVisiblePath()

        return UITargetedPreview(view: preview, parameters: parameter, target: target)
    }

}
