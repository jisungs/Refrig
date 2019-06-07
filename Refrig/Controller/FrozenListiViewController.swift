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
    
    var FrozenItemArray = [Item]()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let newItem = Item()
        newItem.title = "ICE"
        FrozenItemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Coffee"
        FrozenItemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "dumplings"
        FrozenItemArray.append(newItem3)
        
        
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
        
         let item = FrozenItemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Teneary Operation
        // value = condition ? value 1 : value 2 
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    
    }
    
    //MARK - TableView Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(FrozenItemArray[indexPath.row])
        
        //Toggling data modals property
        FrozenItemArray[indexPath.row].done = !FrozenItemArray[indexPath.row].done
        
        FrozenTableView.reloadData()
        
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
            
            
          let newItem = Item()
            newItem.title = textField.text!
            
            self.FrozenItemArray.append(newItem)
            
            self.FrozenTableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        
       // present(alert, animated: true, completion: nil)
        
        //When alert window is opened touch outside cancel action is activated
        self.present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
