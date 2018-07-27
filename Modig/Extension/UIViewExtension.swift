//
//  UIViewExtension.swift
//  Modig
//
//  Created by Nvard Martirosyan on 17.06.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
