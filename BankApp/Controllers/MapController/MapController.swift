//
//  MapController.swift
//  BankApp
//
//  Created by Александр Молчан on 17.01.23.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class MapController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager?
    private var markers: [GMSMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateMapView()
        clusterSettings()
        getData()
    }
    
    private func configurateMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func clusterSettings() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager?.setMapDelegate(self)
    }
    
    private func getData() {

    }
    
    private func drawAtmFilials() {
        
    }
    
}

extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return true
    }
}

extension MapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locationManager.location?.coordinate else {
            locationManager.stopUpdatingLocation()
            return
        }
        cameraMove(to: location)
        locationManager.stopUpdatingLocation()
    }
    
    func cameraMove(to location: CLLocationCoordinate2D) {
            mapView.camera = GMSCameraPosition.camera(withTarget: location, zoom: 8)
    }
    
}
