//
//  PlaciesTableViewCell.swift
//  Modig
//
//  Created by Nvard Martirosyan on 13.06.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class PlaciesTableViewCell: UITableViewCell, FillPlaciseDelegate {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    var lat = Double()
    var lng = Double()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Fill Placies delegate
    
    func fillData(_ data: Place) {
        
        self.placeImageView.downloadImage(photoReferens: data.photoReferens)
        
        self.placeNameLabel.text = data.name
        
        let current = CLLocation(latitude: lat, longitude: lng)
        let itemLoc = CLLocation(latitude: data.lat, longitude: data.lng)
        let distance = itemLoc.distance(from: current)
        self.distanceLabel.text = String(Int(distance)) + "m"
    }
}
