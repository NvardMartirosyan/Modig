//
//  WelcomeViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 12.05.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeImageView: UIImageView!
    let images = [UIImage(named: "bb"), UIImage(named: "aa"), UIImage(named: "tt"), UIImage(named: "vv"), UIImage(named: "dd")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.animateImages()
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let initialLVC = st.instantiateViewController(withIdentifier: "InitialLocationViewControllerID")
        self.navigationController?.show(initialLVC, sender: self)
    }
    
    func animateImages() {
        self.welcomeImageView.animationImages = self.images as? [UIImage]
        self.welcomeImageView.animationDuration = 7.0
        self.welcomeImageView.startAnimating()
    }
}
