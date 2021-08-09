//
//  WeatherCollectionViewCell.swift
//  WeatherApi
//
//  Created by Natallia Askerka on 24.07.21.
//

import UIKit


struct OtherDayModel {
    public var dayTitle: String
    public var minTempTitle: String
    public var maxTempTitle: String
//    public var weatherIconString: String
}

struct DaylyModel {
    public var dayTitle: String
    public var temperature: String
}

struct HourlyModel {
    public var hourTitle: String
    public var temperature: String
}

enum CellDataType {
    case currentDay(city: String, weatherDescription: String, currentTemp: String, minTemp: String, maxTemp: String)
    case hourlyInfo(text: [HourlyModel])
    case otherDays(days: [OtherDayModel])
    case otherInfo(pressure: String, humidity: String, sunset: String, sunrise: String)
}


final class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var myGifView: UIImageView!
    
    private var daysResponse : DaylyModel?
    private var theDayResponse: DaysResponseModel?
    private let dataFetcher = DataFetcherService()
    private var dataSource: [CellDataType] = []
    

    enum DateFormat: String {
        case dayTitle = "EEEE"
        case timeFull = "HH:mm"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        tableView.delegate = self
        tableView.dataSource = self
    
        setupTableView()
        
        dataFetcher.getWeatherDays(count: 7, completion: { [weak self] response in
            guard let self = self, let response = response else { return }
            self.theDayResponse = response
            self.configureDataSourceFrom(response: response)
        })
    }
    func configureDataSourceFrom(response: DaysResponseModel) {
        dataSource.append(.currentDay(city: response.city?.name ?? "",
                                      weatherDescription: response.weather?.description ?? "",
                                      currentTemp: "\(Int(response.list?.first?.temp?.day ?? 0))°",
                                      minTemp: "\(Int(response.list?.first?.temp?.min ?? 0))°",
                                      maxTemp: "\(Int(response.list?.first?.temp?.max ?? 0))°"))
        if let hours = response.list{
            dataSource.append(.hourlyInfo(text: configureCollectionHoursFrom(hours: hours)))
        }
        if let days = response.list {
            dataSource.append(.otherDays(days: configureOtherDaysArrayFrom(days: days)))
        }
         
        if let sunrise = response.list?.first?.sunrise,
           let sunset = response.list?.first?.sunset {
            
            dataSource.append(.otherInfo(pressure: "\(response.list?.first?.pressure ?? 0)",
                                         humidity: "\(response.list?.first?.humidity ?? 0)",
                                         sunset: configureDataStringFrom(epoch: sunset, dateFormat: .timeFull),
                                         sunrise: configureDataStringFrom(epoch: sunrise, dateFormat: .timeFull)))
        }

        tableView.reloadData()
    }
    
    private func configureDataStringFrom(epoch: Int, dateFormat: DateFormat) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: date)
    }
    
    private func configureCollectionDaysFrom(days: [List]) -> [DaylyModel] {
        var collectionDays: [DaylyModel] = []
        for day in days {
            var dayTitlesString = ""
            if let epochInt = day.dt {
                dayTitlesString = configureDataStringFrom(epoch: epochInt, dateFormat: .dayTitle)
            }
            let model = DaylyModel(dayTitle: dayTitlesString,
                                   temperature: "\(Int(day.temp?.day ?? 0))°")
            collectionDays.append(model)
        }
        return collectionDays
    }
    private func configureCollectionHoursFrom(hours: [List]) -> [HourlyModel] {
        var collectionDays: [HourlyModel] = []
        for hour in hours {
            var hourTitlesString = ""
            if let epochInt = hour.dt {
                hourTitlesString = configureDataStringFrom(epoch: epochInt, dateFormat: .timeFull )
            }
            let model = HourlyModel( hourTitle: hourTitlesString,
                                   temperature: "\(Int(hour.temp?.day ?? 0))°")
            collectionDays.append(model)
        }
        return collectionDays
    }
    
    private func configureOtherDaysArrayFrom(days: [List]) -> [OtherDayModel] {
        var otherDays: [OtherDayModel] = []
        
        for day in days {
            var dayTitleString = ""
            
            if let epochInt = day.dt {
                dayTitleString = configureDataStringFrom(epoch: epochInt, dateFormat: .dayTitle)
            }
            
            let model = OtherDayModel(dayTitle: dayTitleString,
                          minTempTitle: "\(Int(day.temp?.min ?? 0))°",
                          maxTempTitle: "\(Int(day.temp?.max ?? 0))°")
//                          weatherIconString: "http://openweathermap.org/img/wn/\(day.weather?.first?.icon ?? "")@2x.png")

            otherDays.append(model)
        }
                
        return otherDays
    }

        func setupTableView() {
            tableView.register(cellType: CurrentWeatherCell.self)
            tableView.register(cellType: HourlyCell.self)
            tableView.register(cellType: OtherDaysCell.self)
            tableView.register(cellType: OtherInfoCell.self)
    
        }
    
    func setupCellWith(model: DaylyModel){
       daysResponse = model
    }
  
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WeatherCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath.row] {
      
        case .hourlyInfo:
            return 66
        case .otherDays, .currentDay, .otherInfo:
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch dataSource[indexPath.row] {
        case .currentDay(city: let city,
                         weatherDescription: let weatherDescription,
                         currentTemp: let currentTemp,
                         minTemp: let minTemp,
                         maxTemp: let maxTemp):
           
           let cell = tableView.dequeueReusableCell(with: CurrentWeatherCell.self, for: indexPath)
           
            let model = CurrentWeatherCellModel(cityString: city,
                                                weatherDescription: weatherDescription,
                                                currentTempString: currentTemp,
                                                minAndMaxTempString: "Макс.\(maxTemp), мин.\(minTemp) ")

            cell.setupCellFrom(model: model)
            cell.backgroundColor = UIColor.clear
            cell.layer.borderWidth = 0.2
            cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            return cell
            
        case .hourlyInfo(text: let text):
            
            let cell = tableView.dequeueReusableCell(with: HourlyCell.self, for: indexPath)
            cell.confugureWith(model: text)
            cell.backgroundColor = UIColor.clear
            cell.layer.borderWidth = 0.2
            cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        return cell
            
        case .otherDays(days: let days):
            let cell = tableView.dequeueReusableCell(with: OtherDaysCell.self, for: indexPath)
            
            cell.setupWith(model: days)
            cell.backgroundColor = UIColor.clear
            cell.layer.borderWidth = 0.2
            cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            return cell
            
            case .otherInfo(pressure: let pressure,
                        humidity: let humidity,
                        sunset: let sunset,
                        sunrise: let sunrise):
            
            
            let cell = tableView.dequeueReusableCell(with: OtherInfoCell.self, for: indexPath)
            let model = OtherInfoCellModel(pressure:  "Давление: \(pressure) гПа", humidity: "Влажность: \(humidity)%", sunrise: "Восход солнца: \(sunrise)",  sunset: "Заход солнца: \(sunset)")
            
            cell.setupOtherInfoCellWith(model: model)
                cell.backgroundColor = UIColor.clear
                cell.layer.borderWidth = 0.2
                cell.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

            return cell
        }

    }


}


extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
