//
//  HourlyCell.swift
//  WeatherApi
//
//  Created by Natallia Askerka on 17.07.21.
//

import UIKit

final class HourlyCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    
    private var dataSourse: [HourlyModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(cellType: CollectionViewViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    func confugureWith(model: [HourlyModel]) {
        dataSourse = model
        collectionView.reloadData()
    }
    
}

extension HourlyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewViewCell.identifier, for: indexPath) as! CollectionViewViewCell
        
        cell.configureWith(model: dataSourse[indexPath.row])
        cell.backgroundColor = UIColor.clear

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 75)
    }
    
    
}

