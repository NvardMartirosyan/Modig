//
//  PlacesTableViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 21.05.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class PlacesTableViewController: UITableViewController {
    
    weak var delegate: FillPlaciseDelegate?

    var type = String()
    var distance = Int()
    var latitude = Double()
    var longitude = Double()
    var placesArray = [Place]()
    var urlNextPageToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNearbyPlace()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action:nil) 
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getNearbyPlace() {
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + String(latitude) + "," + String(longitude) + "&radius=" + String(distance) + "&type=" + type + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8"
        print(url)
        
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                guard let jsonDictionory = json as? [String : Any],
                      let results = jsonDictionory["results"] as? [[String : AnyObject]] else {
                    return
                }
                
                for aPlaceData in results {
                    let place  = Place(withJsonData: aPlaceData)
                    self.placesArray.append(place)
                }
                
                if  let pagetoken = jsonDictionory["next_page_token"] as? String {
                    self.urlNextPageToken = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=" + pagetoken + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8"
                }
                
                if self.placesArray == [] {
                    self.placeIsNotFound()
                }
            }
            print(self.urlNextPageToken)
            HUD.flash(.progress, onView: self.view, delay: 1.0) { progress in
                self.tableView.reloadData()
           }
        }
    }
    
    // ***** when place not found *****
    
    func placeIsNotFound() {
        let alertController = UIAlertController(title: "Place not found", message: "At this distance there is no such place", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { cancel in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func nextPageToken() {
        
        Alamofire.request(self.urlNextPageToken).responseJSON { response in
            if let json = response.result.value {
                guard let jsonDictionory = json as? [String : Any],
                    let results = jsonDictionory["results"] as? [[String : AnyObject]] else {
                        return
                }
                
                for aPlaceData in results {
                    let place  = Place(withJsonData: aPlaceData)
                    self.placesArray.append(place)
                }
                
                if  let pagetoken = jsonDictionory["next_page_token"] as? String {
                    self.urlNextPageToken = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=" + pagetoken + "&key=AIzaSyCWwIDvM4iFYHcBYi6-HPB6XdB_SE3-5Z8"
                } else {
                    self.urlNextPageToken = ""
                }
                print(self.urlNextPageToken)
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_identifier", for: indexPath) as! PlaciesTableViewCell
        let place = placesArray[indexPath.row]
        self.delegate = cell
        cell.lat = self.latitude
        cell.lng = self.longitude
        self.delegate?.fillData(place)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = placesArray[indexPath.row]
        navigateToDescVC(with: place)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == placesArray.count {
            if self.urlNextPageToken != "" {
                nextPageToken()
                print("came to last row")
            }
        }
    }
    
    //MARK: - Navigation Metods
    
    func navigateToDescVC(with place: Place) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "DescriptionTableViewControllerID") as! DescriptionTableViewController
        vc.place = place
        vc.lat = place.lat
        vc.lng = place.lng
        self.navigationController?.show(vc, sender: self)
    }
}
