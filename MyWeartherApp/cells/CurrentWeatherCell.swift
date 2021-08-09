//
//  CurrentWeatherCell.swift
//  APIExample
//
//  Created by Aleksei Elin on 15.07.21.
//

import UIKit

struct CurrentWeatherCellModel {
    let cityString: String
    let weatherDescription: String
    let currentTempString: String
    let minAndMaxTempString: String
}

final class CurrentWeatherCell: UITableViewCell {
    @IBOutlet private weak var cityTitleLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var minAndMaxTempLabel: UILabel!
    
    func setupCellFrom(model: CurrentWeatherCellModel) {
        cityTitleLabel.text = model.cityString
        weatherDescriptionLabel.text = model.weatherDescription
        currentTempLabel.text = model.currentTempString
        minAndMaxTempLabel.text = model.minAndMaxTempString
    }
}
