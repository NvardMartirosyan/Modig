//
//  Place.swift
//  Modig
//
//  Created by Nvard Martirosyan on 10.06.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit

class Place: NSObject {
    var name = ""
    var id = ""
    var rating = 1.0
    var categories = [String]()
    var address = ""
    var isOpenNow = false
    var photoReferens = ""
    var lat = Double()
    var lng = Double()
    
    
    init(withJsonData jsonData: [String : Any]) {
        guard let name = jsonData["name"] as? String,
              let id = jsonData["place_id"] as? String,
              let categories = jsonData["types"] as? [String],
              let address = jsonData["vicinity"] as? String else {
                print("error")
                return
        }
        self.name = name
        self.id = id
        self.categories = categories
        self.address = address
        if let photos = jsonData["photos"] as? [[String : Any]] {
            for photo in photos {
                self.photoReferens = photo["photo_reference"] as! String
            }
        }
        if let openingHoursDict = jsonData["opening_hours"] as? [String : Any],
            let isOpen = openingHoursDict["open_now"] as? Bool {
            self.isOpenNow = isOpen
        }
        
        if let rating = jsonData["rating"] as? Double {
            self.rating = rating
        }
        
        if let geometry = jsonData["geometry"] as? [String:Any],
            let location = geometry["location"] as? [String:Double],
            let lat = location["lat"],
            let lng = location["lng"] {
            self.lat = lat
            self.lng = lng
            
        }
        
        
        
        
        
        
        
        
    }
}
