//
//  CategoresTableViewController.swift
//  Modig
//
//  Created by Nvard Martirosyan on 19.05.2018.
//  Copyright © 2018 iOS_Gyumri. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    
    weak var delegate : CategoriesTableViewControllerDelegate?
    
    var data = Array<String>()
    var selectedIndexPath = IndexPath()
    var selectedRow = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        let next = UIBarButtonItem (title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(next(_:)))
        self.navigationItem.rightBarButtonItem = next
        tableView.animateTable()
    }
    
    @objc func next(_ sender: UIBarButtonItem) {
        self.delegate?.categoriesTableViewController(categoriesTableViewController: self, onClick: self.selectedRow)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category_cell", for: indexPath)
        cell.textLabel?.text = self.data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        cell.accessoryType = .none
        
        if indexPath == self.selectedIndexPath {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        self.selectedIndexPath = indexPath
        self.selectedRow = self.data[indexPath.row]
    }
}
