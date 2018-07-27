//
//  InitialLocationViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 21.05.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit

class InitialLocationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Button action
    
    @IBAction func turnOnButtonAction(_ sender: UIButton) {
        
        navigateToLocationVC()
    }
    
    @IBAction func skipForNowButtonAction(_ sender: UIButton) {
        
        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
        
    }
    
    //MARK: - Navigation Metods
    
    func navigateToLocationVC() {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let lVC = st.instantiateViewController(withIdentifier: "LocationViewControllerID") as! LocationViewController
        self.navigationController?.show(lVC, sender: self)
    }
}
