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
    private var citySelectedIndex = IndexPath(row: 0, section: 0)
    private var filterSelectedIndex = IndexPath(row: 0, section: 0)
    private var selectedFilter = FilterButtons.all
    
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
        
        filterCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        cityCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
                
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

}

// MARK: -
// MARK: - GoogleMap extension

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

// MARK: -
// MARK: - CollectionViews extension

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
            filterCell.isSelected = indexPath == filterSelectedIndex
            filterCell.set(button: filterButtons[indexPath.row])
            return filterCell
        } else {
            let cell = cityCollectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath)
            guard let cityCell = cell as? CityCell else { return cell }
            cityCell.isSelected = indexPath == citySelectedIndex
            cityCell.setCollectionCell(city: towns[indexPath.row])
            return cityCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cityCollectionView {
//            self.selectedFilter = filterButtons[indexPath.row]
            self.citySelectedIndex = indexPath
            self.drawMarkersFor(index: filterSelectedIndex, city: towns[citySelectedIndex.row])
            self.cityCollectionView.reloadData()
        } else {
            self.filterSelectedIndex = indexPath
            self.drawMarkersFor(index: filterSelectedIndex, city: towns[citySelectedIndex.row])
            self.filterCollectionView.reloadData()
        }
    }
    
}

extension MapController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        let inset = 5.0
        let width = (screen.bounds.width - (inset * (6))) / 3
        return CGSize(width: width, height: 30)
    }
}

// MARK: -
// MARK: - Get Data functions extencion

extension MapController {
    private func drawMarkersFor(index: IndexPath, city: String) {
        mapView.clear()
        clusterManager?.clearItems()
        activityIndicator.startAnimating()
        
        if index == IndexPath(row: 0, section: 0) {
            FilialProvider().getAtmInfo(city: city) { [weak self] result in
                guard let self else { return }
                self.drawAtm(source: result)
                FilialProvider().getFilialsInfo(city: city) { [weak self] result in
                    guard let self else { return }
                    self.drawFilial(source: result)
                    self.activityIndicator.stopAnimating()
                } failure: { error in
                    print("We have \(error)")
                    self.activityIndicator.stopAnimating()
                }
            } failure: { error in
                print("We have \(error)")
                self.activityIndicator.stopAnimating()
            }
            
        } else if index == IndexPath(row: 1, section: 0) {
            FilialProvider().getAtmInfo(city: city) { [weak self] result in
                guard let self else { return }
                self.drawAtm(source: result)
                self.activityIndicator.stopAnimating()
            } failure: { error in
                print("We have \(error)")
                self.alertResponceCrash()
                self.activityIndicator.stopAnimating()
            }
            
        } else if index == IndexPath(row: 2, section: 0) {
            FilialProvider().getFilialsInfo(city: city) { [weak self] result in
                guard let self else { return }
                self.drawFilial(source: result)
                self.activityIndicator.stopAnimating()
            } failure: { error in
                print("We have \(error)")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
//    private func newdrawMarkersFor(index: IndexPath, city: String) {
//        switch selectedFilter {
//
//            case .all:
//                <#code#>
//            case .atm:
//                <#code#>
//            case .filial:
//                <#code#>
//        }
//
//        // нужно сделать корояе, обернуть функции запроса в отдельные функции.
//    }

    private func drawAtm(source: [AtmInfo]) {
        source.forEach { atm in
            guard let latitude = Double(atm.latitude),
                  let longitude = Double(atm.longitude) else { return }
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            if atm.atmError == "да" {
                marker.icon = GMSMarker.markerImage(with: UIColor.green)
            } else {
                marker.icon = GMSMarker.markerImage(with: UIColor.red)
            }
            clusterManager?.add(marker)
            marker.map = mapView
            marker.userData = atm
            mapView.clear()
            clusterManager?.cluster()
        }
    }
    
    private func drawFilial(source: [FilialInfo]) {
        source.forEach { filial in
            guard let latitude = Double(filial.latitude),
                  let longitude = Double(filial.longitude) else { return }
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            marker.icon = GMSMarker.markerImage(with: UIColor.yellow)
            clusterManager?.add(marker)
            marker.map = mapView
            marker.userData = filial
            mapView.clear()
            clusterManager?.cluster()
        }
    }
    
    private func alertResponceCrash() {
        let alert = UIAlertController(title: "Ошибка", message: "В данном регионе не обнаружено банкоматов", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Печально(", style: .default)
        alert.addAction(okBtn)
        present(alert, animated: true)
    }
}
