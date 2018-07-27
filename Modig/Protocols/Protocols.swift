//
//  Protocols.swift
//  Modig
//
//  Created by Nvard Martirosyan on 14.06.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import Foundation

protocol CategoriesTableViewControllerDelegate: class {
    func categoriesTableViewController(categoriesTableViewController: CategoriesTableViewController,onClick selectedData: String)
}

protocol FillPlaciseDelegate: class {
    func fillData(_ data: Place)
}
