//
//  WratherManager.swift
//  MyWeartherApp
//
//  Created by Natallia Askerka on 7.08.21.
//
import Foundation
import MapKit

class WeatherManager {
    
    static let shared = WeatherManager()
    private init() {}
    
    private let API_ACCESS_KEY = "65366cce655fb7ef8e2affbb6382018f"
    private let API_URL = "http://api.weatherstack.com"
    
    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (String)->()) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let query = String(latitude) + "," + String(longitude)
        
        print(query)
        guard let url = URL(string: self.API_URL + "/current?access_key=" + self.API_ACCESS_KEY + "&query=" + query ) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error == nil, let data = data {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let json = jsonResult as? [String: Any],
                       let current = json["current"] as? [String: Any],
                       let temperature = current["temperature"] as? Int {
                        completion("\(temperature)")
                    }
                } catch {
                    print(error)
                    completion("error")
                }
            } else {
                print(error?.localizedDescription ?? "error")
                completion("error")
            }
        }
        task.resume()
    }
}
