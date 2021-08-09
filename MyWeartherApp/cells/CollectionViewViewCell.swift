//
//  CollectionViewViewCell.swift
//  WeatherApi
//
//  Created by Natallia Askerka on 17.07.21.
//

import UIKit


struct CollectionViewViewCellModel {
    var  temperatureString: String
    var dayString: String
}

final class CollectionViewViewCell: UICollectionViewCell {
    
    
    static let identifier = "CollectionViewViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewViewCell", bundle: nil)
    }
    
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    
    
    func configureWith(model: HourlyModel){
        self.tempLabel.text = model.temperature
        self.dayLabel.text = model.hourTitle
    }
    
    
}
