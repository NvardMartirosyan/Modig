//
//  UIImageViewExtension.swift
//  Modig
//
//  Created by Nvard Martirosyan on 04.07.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
//   class func downloadImage(placeImageView: UIImageView, photoReferens: String) {
//        if photoReferens != "" {
//                let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + photoReferens + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8")
//              placeImageView.af_setImage(withURL: url! as URL)
//                } else {
//              placeImageView.image = UIImage(named: "noimagefound")
//                }
//    }
//}


  func downloadImage(photoReferens: String) {
        if photoReferens != "" {
            let url = NSURL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + photoReferens + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8")
            self.af_setImage(withURL: url! as URL)
        } else {
            self.image = UIImage(named: "noimagefound")
        }
    }
}
