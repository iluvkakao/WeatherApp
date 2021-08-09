//
//  SearchingCitiesViewController.swift
//  MyWeartherApp
//
//  Created by Natallia Askerka on 26.07.21.
//

import UIKit
import MapKit
//import GooglePlaces


final class SearchingCitiesViewController: UIViewController {
    
    let mapView = MKMapView()
    let searchVC = UISearchController(searchResultsController: ResultOfSearchingCitiesViewController())
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Поиск"
        view.addSubview(mapView)
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(revealRegionDetails(sender:)))
        mapView.addGestureRecognizer(recognizer)
        
    }

     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
   
    }
    @IBAction func revealRegionDetails(sender: UITapGestureRecognizer){
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        WeatherManager.shared.sendRequest(coordinates: locationCoordinate) { (temperature) in
            DispatchQueue.main.async {
                let point = MKPointAnnotation()
                point.coordinate = locationCoordinate
                point.title = "\( temperature)"
                self.mapView.addAnnotation(point)
            }
        }
    }
    

    

}
extension SearchingCitiesViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
    
    


