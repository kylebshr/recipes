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

    private let locations = [Location()]

    private var currentLocationView: UIView?

    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)

        tabBarItem = UITabBarItem(title: "Map", image: UIImage(symbol: .map), selectedImage: nil)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpMapView()

        let interaction = UIContextMenuInteraction(delegate: self)
        view.addInteraction(interaction)

    }

    private func setUpMapView() {

        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.frame = view.bounds
        mapView.delegate = self

        let coordinate = CLLocationCoordinate2D(latitude: 37.74465653852542, longitude: -122.3926921078639)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: false)

        view.addSubview(mapView)

        for location in locations {
            mapView.addAnnotation(location)
        }

    }

    private func showDetails(for location: Location) {

        currentLocationView?.removeFromSuperview()

        let locationView = LocationDetailView(location: location) { [weak self] in
            self?.mapView.deselectAnnotation(nil, animated: false)
        }

        locationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationView)

        let visibleAnchor = locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let hiddenAnchor = locationView.topAnchor.constraint(equalTo: view.bottomAnchor)

        let widthOrTrailingAnchor: NSLayoutConstraint
        if traitCollection.userInterfaceIdiom == .pad {
            widthOrTrailingAnchor = locationView.widthAnchor.constraint(equalToConstant: 300)
        } else {
            widthOrTrailingAnchor = locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        }

        NSLayoutConstraint.activate([

            hiddenAnchor, widthOrTrailingAnchor,
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

        ])

        view.layoutIfNeeded()

        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            hiddenAnchor.isActive = false
            visibleAnchor.isActive = true
            self.view.layoutIfNeeded()
        }.startAnimation()

        currentLocationView = locationView

    }

    private func hideDetails() {

        guard let currentLocationView = currentLocationView else {
            return
        }

        UIView.animate(withDuration: 0.4, animations: {
            let translation = CATransform3DMakeTranslation(0, currentLocationView.frame.minY, 0)
            currentLocationView.layer.transform = translation
        }, completion: { _ in
            currentLocationView.removeFromSuperview()
        })

        self.currentLocationView = nil

    }

}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        return OfficeAnnotationView()

    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        guard let location = view.annotation as? Location else {
            return
        }

        showDetails(for: location)

    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

        hideDetails()

    }

}

// MARK: - Context Menus

extension MapViewController: UIContextMenuInteractionDelegate {

    // 1. Set up an interaction
    //    - Add in viewDidLoad

    // 2. Create a menu configuration
    //    - Check that the interaction is occuring on an annotation

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        guard let annotationView = view.hitTest(location, with: nil) as? OfficeAnnotationView else {
            return nil
        }

        guard let annotation = annotationView.annotation as? Location else {
            return nil
        }

        return UIContextMenuConfiguration(identifier: annotation.menuID, previewProvider: nil) { _ in

            let favorite = UIAction(title: "Favorite", image: UIImage(symbol: .heart)) { _ in
                print("Favorite")
            }

            let share = UIAction(title: "Share", image: UIImage(symbol: .share)) { _ in
                print("Share")
            }

            return UIMenu(title: annotation.title ?? "", image: nil, identifier: nil, options: [], children: [favorite, share])

        }

    }

    // 3. Create highlight preview
    //    - Custom view not in the hierarchy

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        guard let location = locations.item(for: configuration) else {
            return nil
        }

        let preview = OfficePreviewView(image: location.photo)

        let target = UIPreviewTarget(container: view, center: interaction.location(in: view))

        return UITargetedPreview(view: preview, parameters: UIPreviewParameters(), target: target)

    }

    // 4. Polish our preview with a custom shape

    // 5. Polish our animation when tapping on preview

}
