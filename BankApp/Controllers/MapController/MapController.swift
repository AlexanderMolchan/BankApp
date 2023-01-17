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
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    private var locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager?
    private var markers: [GMSMarker] = []
    private var towns = [String]()
    private var filterButtons = FilterButtons.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateMapView()
        clusterSettings()
        collectionViewsSettings()
        getCityData()

    }
    
    private func configurateMapView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
//        mapView.settings.myLocationButton = true
        
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
    
    private func collectionViewsSettings() {
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        
        cityCollectionView.register(UINib(nibName: CityCell.id, bundle: nil), forCellWithReuseIdentifier: CityCell.id)
        filterCollectionView.register(UINib(nibName: FilterCell.id, bundle: nil), forCellWithReuseIdentifier: FilterCell.id)
    }
    
    private func getCityData() {
        self.activityIndicator.startAnimating()
        FilialProvider().getAtmCityList { [weak self] result in
            guard let self else { return }
            result.forEach { model in
                if !self.towns.contains(model.city), model.cityType == "г." {
                    self.towns.append(model.city)
                }
            }
            FilialProvider().getFilialCityList { [weak self] result in
                guard let self else { return }
                result.forEach { model in
                    if !self.towns.contains(model.city), model.cityType == "г." {
                        self.towns.append(model.city)
                    }
                }
                self.cityCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            } failure: { error in
                print("We have \(error)")
            }
        } failure: { error in
            print("We have \(error)")
        }
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

extension MapController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView {
            return filterButtons.count
        } else {
            return towns.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.id, for: indexPath)
            guard let filterCell = cell as? FilterCell else { return cell }
            filterCell.set(button: filterButtons[indexPath.row])
            return filterCell
        } else {
            let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
            guard let cityCell = cell as? CityCell else { return cell }
            cityCell.setCollectionCell(city: towns[indexPath.row])
            return cityCell
        }
    }
    
}
