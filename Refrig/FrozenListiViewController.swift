//
//  FrozenListiViewController.swift
//  Refrig
//
//  Created by The book Air on 03/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import UIKit


class FrozenListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var FrozenTableView: UITableView!
    
    var FrozenItemArray = ["Ice", "shrimp", "dumpings"]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        FrozenTableView.delegate = self
        FrozenTableView.dataSource = self
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPreesed(sender:)))
        self.navigationItem.rightBarButtonItem = add
        add.tintColor = UIColor.white
        

    }
    
    //When touch outside of keyboard it reset the position
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //when Retrun input occuerd the keyboard is reset 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FrozenItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrozenItemCell", for: indexPath)
        
        cell.textLabel?.text = FrozenItemArray[indexPath.row]
        
        return cell
        
        
    }
    
    //MARK - TableView Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(FrozenItemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Remove cell using swipe action
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            FrozenItemArray.remove(at: indexPath.row)
            
            FrozenTableView.reloadData()
            
        }
    }
    
    //MARK - Add new Item
    
    @objc func addButtonPreesed(sender: UIBarButtonItem){
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let newItem = textField.text {
                  self.FrozenItemArray.append(newItem)
            }
          
            
            self.FrozenTableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
