//
//  DataFetcherService.swift
//  Papa Johns Codes
//
//  Created by Aleksei Elin on 19.09.2019.
//  Copyright © 2019 Aleksei Elin. All rights reserved.
//

import Foundation

class DataFetcherService {    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }

    
    func getWeather(completion: @escaping (WeatherResponse?) -> Void) {
        let urlForWeather = "https://api.openweathermap.org/data/2.5/weather"
        let params: [String : String] = ["q"     : "Minsk",
                                         "appid" : "64b33b91272f06dc53f406df2349ea19",
                                         "lang"  : "ru",
                                         "units" : "metric"]
        
        networkDataFetcher.genericJSONDataWith(type: .GET, urlString: urlForWeather,
                                               parameters: params, response: completion)
    }
    
    
    func getWeatherDays(count: Int, completion: @escaping (DaysResponseModel?) -> Void) {
        let urlForWeather = "https://api.openweathermap.org/data/2.5/forecast/daily"
        let params: [String : String] = ["q"     : "Minsk",
                                         "appid" : "64b33b91272f06dc53f406df2349ea19",
                                         "lang"  : "ru",
                                         "units" : "metric",
                                         "cnt"   : "\(count)"]
        
        networkDataFetcher.genericJSONDataWith(type: .GET, urlString: urlForWeather,
                                               parameters: params, response: completion)
    }
    
    
    
    
}
