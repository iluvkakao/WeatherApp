//
//  OtherInfoCell.swift
//  WeatherApi
//
//  Created by Natallia Askerka on 17.07.21.
//

import UIKit

struct OtherInfoCellModel {
    let pressure: String
    let humidity: String
    let sunrise: String
    let sunset: String
}

final class OtherInfoCell: UITableViewCell {
    
 
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLbl: UILabel!
    @IBOutlet private weak var sunriseLbl: UILabel!
    @IBOutlet private weak var sunsetLbl: UILabel!
    
    func setupOtherInfoCellWith(model: OtherInfoCellModel){
        pressureLabel.text = model.pressure
        humidityLbl.text = model.humidity
        sunriseLbl.text = model.sunrise
        sunsetLbl.text = model.sunset
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
}
