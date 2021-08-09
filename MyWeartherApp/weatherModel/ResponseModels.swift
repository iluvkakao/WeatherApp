//
//  ResponseModels.swift
//  APIExample
//
//  Created by Aleksei Elin on 12.07.21.
//

import Foundation

struct DaysResponseModel : Codable {
    let city : City?
    let cod : String?
    let message : Double?
    let cnt : Int?
    let list : [List]?
    let weather : [Weather]?

    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case weather = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try? values.decodeIfPresent(City.self, forKey: .city)
        cod = try? values.decodeIfPresent(String.self, forKey: .cod)
        message = try? values.decodeIfPresent(Double.self, forKey: .message)
        cnt = try? values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try? values.decodeIfPresent([List].self, forKey: .list)
        weather = try? values.decodeIfPresent([Weather].self, forKey: .weather)

    }
}

struct City : Codable {
    let id : Int?
    let name : String?
    let coord : Coord?
    let country : String?
    let population : Int?
    let timezone : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        coord = try? values.decodeIfPresent(Coord.self, forKey: .coord)
        country = try? values.decodeIfPresent(String.self, forKey: .country)
        population = try? values.decodeIfPresent(Int.self, forKey: .population)
        timezone = try? values.decodeIfPresent(Int.self, forKey: .timezone)
    }
}

struct Feels_like : Codable {
    let day : Double?
    let night : Double?
    let eve : Double?
    let morn : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case day = "day"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try? values.decodeIfPresent(Double.self, forKey: .day)
        night = try? values.decodeIfPresent(Double.self, forKey: .night)
        eve = try? values.decodeIfPresent(Double.self, forKey: .eve)
        morn = try? values.decodeIfPresent(Double.self, forKey: .morn)
    }
}

struct List : Codable {
    let dt : Int?
    let sunrise : Int?
    let sunset : Int?
    let temp : Temp?
    let feels_like : Feels_like?
    let pressure : Int?
    let humidity : Int?
    let weather : [Weather]?
    let speed : Double?
    let deg : Int?
    let gust : Double?
    let clouds : Int?
    let pop : Double?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feels_like = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
        case clouds = "clouds"
        case pop = "pop"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try? values.decodeIfPresent(Int.self, forKey: .dt)
        sunrise = try? values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try? values.decodeIfPresent(Int.self, forKey: .sunset)
        temp = try? values.decodeIfPresent(Temp.self, forKey: .temp)
        feels_like = try? values.decodeIfPresent(Feels_like.self, forKey: .feels_like)
        pressure = try? values.decodeIfPresent(Int.self, forKey: .pressure)
        humidity = try? values.decodeIfPresent(Int.self, forKey: .humidity)
        weather = try? values.decodeIfPresent([Weather].self, forKey: .weather)
        speed = try? values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try? values.decodeIfPresent(Int.self, forKey: .deg)
        gust = try? values.decodeIfPresent(Double.self, forKey: .gust)
        clouds = try? values.decodeIfPresent(Int.self, forKey: .clouds)
        pop = try? values.decodeIfPresent(Double.self, forKey: .pop)
    }
    
}

struct Temp : Codable {
    let day : Double?
    let min : Double?
    let max : Double?
    let night : Double?
    let eve : Double?
    let morn : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try? values.decodeIfPresent(Double.self, forKey: .day)
        min = try? values.decodeIfPresent(Double.self, forKey: .min)
        max = try? values.decodeIfPresent(Double.self, forKey: .max)
        night = try? values.decodeIfPresent(Double.self, forKey: .night)
        eve = try? values.decodeIfPresent(Double.self, forKey: .eve)
        morn = try? values.decodeIfPresent(Double.self, forKey: .morn)
    }
}
struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        main = try? values.decodeIfPresent(String.self, forKey: .main)
        description = try? values.decodeIfPresent(String.self, forKey: .description)
        icon = try? values.decodeIfPresent(String.self, forKey: .icon)
    }

}
