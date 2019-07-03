//
//  AlertViewController.swift
//  Refrig
//
//  Created by The book Air on 14/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit
import CoreData

class AlertViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //Sliding up whed keyboard appeared
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 200
                //self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    let FrozenListVC = FrozenListViewController()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var StorageName: UILabel!
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var exDate: UIDatePicker!
    
    
    @IBAction func camera(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: Any) {
        
        let newItem = Item(context: self.context)
        newItem.title = itemName.text!
        newItem.done = false
        newItem.exDate = Date()
        
       
        FrozenListViewController().FrozenItemArray.append(newItem)
        
        saveItem()
        
    }
    
    
    func saveItem(){
        do {
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        let FrozenListTable = FrozenListViewController().FrozenTableView
        
        if FrozenListTable != nil {
            FrozenListTable?.reloadData()
        }else {
            print("Error when reload data")
        }
        
       // FrozenListViewController().FrozenTableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
    
        do{
            FrozenListViewController().FrozenItemArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
        
        FrozenListViewController().FrozenTableView.reloadData()
    }
}
