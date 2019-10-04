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

    private var currentLocationView: UIView?

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

        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.frame = view.bounds
        view.addSubview(mapView)

        let office = Location()
        let region = MKCoordinateRegion(center: office.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
        mapView.addAnnotation(office)
        mapView.delegate = self

    }

    private func showDetails(for location: Location) {

        currentLocationView?.removeFromSuperview()

        let locationView = LocationDetailView(location: location)
        locationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationView)

        let visibleAnchor = locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let hiddenAnchor = locationView.topAnchor.constraint(equalTo: view.bottomAnchor)

        NSLayoutConstraint.activate([

            hiddenAnchor,
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

        ])

        view.layoutIfNeeded()

        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            hiddenAnchor.isActive = false
            visibleAnchor.isActive = true
            self.view.layoutIfNeeded()
        }.startAnimation()

        currentLocationView = locationView

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

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        guard let location = view.annotation as? Location else {
            return
        }

        showDetails(for: location)

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

        let animator = UIViewPropertyAnimator.init(duration: 0.3, curve: .easeInOut) {
            self.currentLocationView?.alpha = 0
        }

        animator.addCompletion { _ in
            self.currentLocationView?.removeFromSuperview()
        }

        animator.startAnimation()

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

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {

        animator.preferredCommitStyle = .dismiss

        guard let view = interaction.view as? OfficeAnnotationView else {
            return
        }

        guard let location = view.annotation as? Location else {
            return
        }

        mapView.selectAnnotation(location, animated: false)

    }

}
