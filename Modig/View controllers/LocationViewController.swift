//
//  LocationViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 14.05.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CategoriesTableViewControllerDelegate, CLLocationManagerDelegate {
    
    var type = String()
    var distance = Int()
    var latitude = Double()
    var longitude = Double()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var categoriesButton: UIButton!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var mOrKmSegmentControl: UISegmentedControl!
    @IBOutlet weak var distanceValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        // For ise when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - CLLocation Manager delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate.latitude, location.coordinate.longitude )
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.denied {
            showLocationDisabeledPopUp()
        } else if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            UserDefaults.standard.set(true, forKey: "notFirstInApp")
        }
    }
    
    //MARK: - Go to settings
    
    func showLocationDisabeledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled", message: "To show places you are interested we need your location", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Button action
    
    @IBAction func categoryButtonAction(_ sender: UIButton) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "CategoriesTableViewControllerID") as! CategoriesTableViewController
        vc.data = categoriesArray
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        
        if self.type == "" && self.distance == 0 {
            sender.shake()
            self.categoriesButton.titleLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.distanceValueLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if self.type == "" {
            sender.shake()
            self.categoriesButton.titleLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else if self.distance == 0 {
            sender.shake()
            self.distanceValueLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            navigateToPlaciesTableViewController()
        }
    }
    
    @IBAction func actionSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 || sender.selectedSegmentIndex == 1 {
            self.distanceValueLabel.text = "0"
            self.distanceSlider.value = 0
        }
    }
    
    @IBAction func actionSlider(_ sender: UISlider) {
        
        if self.mOrKmSegmentControl.selectedSegmentIndex == 0 {
            self.distanceValueLabel.text = String(format: "%.0f%@", sender.value,"m")
            self.distanceSlider.minimumValue = 0
            self.distanceSlider.maximumValue = 5000
            self.distanceValueLabel.textColor = #colorLiteral(red: 0, green: 0.7265984416, blue: 0, alpha: 1)
            self.distance = Int(sender.value)
            
        } else if self.mOrKmSegmentControl.selectedSegmentIndex == 1 {
            
            self.distanceValueLabel.text = String(format: "%.0f%@", sender.value,"Km")
            self.distanceSlider.minimumValue = 0
            self.distanceSlider.maximumValue = 50
            self.distanceValueLabel.textColor = #colorLiteral(red: 0, green: 0.7265984416, blue: 0, alpha: 1)
            self.distance = Int(sender.value) * 1000
        }
    }
    
    //MARK: - Navigation Metods
    
    func navigateToPlaciesTableViewController() {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "PlacesTableViewControllerID") as! PlacesTableViewController
        vc.type = self.type
        vc.distance = self.distance
        vc.latitude = self.latitude
        vc.longitude = self.longitude
        self.navigationController?.show(vc, sender: self)
    }
    
    // MARK: - Categories table view controller delegate
    
    func categoriesTableViewController(categoriesTableViewController: CategoriesTableViewController, onClick selectedData: String) {
        self.categoriesButton .setTitle(selectedData, for: UIControlState.normal)
        type = categoriesDict[selectedData]!
    }
}
