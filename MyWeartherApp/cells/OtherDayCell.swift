//
//  OtherDayCell.swift
//  APIExample
//
//  Created by Aleksei Elin on 15.07.21.
//

import UIKit
import SDWebImage


final class OtherDayCell: UITableViewCell {
    
//    @IBOutlet private weak var gifImage: UIImageView!
    @IBOutlet private weak var dayTitleLabel: UILabel!
//    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var minAndMaxTemp: UILabel!
    
    func setupWith(model: OtherDayModel) {
        dayTitleLabel.text = model.dayTitle
        minAndMaxTemp.text = "\(model.minTempTitle )  " + "\( model.maxTempTitle)"
        
//        weatherImage.sd_setImage(with: URL(string: model.weatherIconString),
//                                 placeholderImage: nil,
//                                 options: .refreshCached, context: nil)

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        gifImage.loadGif(name: "giphy")
    }
    
}

