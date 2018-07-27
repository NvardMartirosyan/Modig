//
//  DescriptionTableViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 14.06.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DescriptionTableViewController: UITableViewController {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var formattedPhonNumberLabel: UILabel!
    @IBOutlet weak var internationalPhoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var phonNumberLabel: UITableViewCell!
    @IBOutlet var workingHoursCollection: [UILabel]!
    @IBOutlet weak var workingHoursCell: UITableViewCell!
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    var placeDescriptionArray = [[String : AnyObject]]()
    var place: Place?
    var star = ""
    var formattedPhonNumber = ""
    var internationalPhoneNumber = ""
    var workingHours = [String]()
    var lat = Double()
    var lng = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action:nil)
        fillPlace()
        
        let seeInMap = UIBarButtonItem (title: "See in map", style: UIBarButtonItemStyle.plain, target: self, action: #selector(seeInMap(_:)))
        self.navigationItem.rightBarButtonItem = seeInMap
    }
    
    @objc func seeInMap(_ sender: UIBarButtonItem) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "MapViewControllerID") as! MapViewController
        vc.lat = (place?.lat)!
        vc.lng = (place?.lng)!
       self.navigationController?.show(vc, sender: self)
    }
    
    
    // MARK: - Button action
    
    @IBAction func moreButtonAction(_ sender: Any) {
        self.formattedPhonNumberLabel.isHidden = false
        self.internationalPhoneNumberLabel.isHidden = false
        self.phonNumberLabel.isHidden = false
        self.moreButton.isHidden = true
        
        if self.workingHours != [] {
            self.workingHoursCell.isHidden = false
        }
        
        fillPlaceDescription(with: self.formattedPhonNumber, internationalPhoneNumber: self.internationalPhoneNumber, workingHours: self.workingHours)
    }
    
    func getPlaceDescription(_ place: Place) {
        
        let url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + place.id + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8"
        print(url)
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                if let jsonDictionary = json as? [String : Any],
                    let result = jsonDictionary["result"] as? [String : AnyObject] {
                    if let formattedPhonNumber = result["formatted_phone_number"] as? String {
                        self.formattedPhonNumber = formattedPhonNumber
                    }
                    if  let internationalPhoneNumber = result["international_phone_number"] as? String {
                        self.internationalPhoneNumber = internationalPhoneNumber
                    }
                    if let openingHours = result["opening_hours"] as? [String : Any],
                        let workingHours = openingHours["weekday_text"] as? [String]  {
                        self.workingHours = workingHours
                    }
                    
                    if let website = result["website"] as? String {
                        self.websiteLabel.text = "🌐" + website
                    }
                    
                    if self.formattedPhonNumber == "" && self.internationalPhoneNumber == "" {
                        self.moreButton.isHidden = true
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func fillPlaceDescription(with formattedPhonNumber: String = "", internationalPhoneNumber: String = "", workingHours: [String] = []) {
        self.formattedPhonNumberLabel.text = formattedPhonNumber
        self.internationalPhoneNumberLabel.text = internationalPhoneNumber
        for i in 0..<workingHours.count {
            self.workingHoursCollection[i].text = workingHours[i]
        }
    }
    
    func fillPlace() {
        
        guard let place = self.place else {
            return
        }

     self.placeImageView.downloadImage(photoReferens: place.photoReferens)
        
        self.placeNameLabel.text = place.name
        self.addressLabel.text = place.address
        
        for _ in 1...Int(place.rating) {
            star += "★"
        }
        
        self.ratingLabel.text = String(format: "%.1f", (place.rating)) + star + """
        ☆
        Ratings
        """
        getPlaceDescription(place)
        
    }
}
