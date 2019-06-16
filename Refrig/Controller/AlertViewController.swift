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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var StorageName: UILabel!
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var exDate: UIDatePicker!
    
    
    override func viewDidLoad(){
        
    }
    
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
        
        FrozenListViewController().FrozenTableView.reloadData()
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
