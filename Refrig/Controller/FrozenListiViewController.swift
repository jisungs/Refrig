//
//  FrozenListiViewController.swift
//  Refrig
//
//  Created by The book Air on 03/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit
import CoreData


class FrozenListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
  
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPreesed(sender:)))
        self.navigationItem.rightBarButtonItem = add
        add.tintColor = UIColor.white
        
    }
    

    
    let alertService = AlertService()
    
    var selectedStorage : Storage? {
        didSet{
            loadItems()
        }
    }
    
    @IBOutlet weak var FrozenTableView: UITableView!
    
    
    var FrozenItemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
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
        
       saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Remove cell using swipe action
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.context.delete(FrozenItemArray[indexPath.row])
            FrozenItemArray.remove(at: indexPath.row)
            saveItem()
            
        }
    }
    
    //MARK - Add new Item
    
    @objc func addButtonPreesed(sender: UIBarButtonItem){
        
        //var textField = UITextField()
        
        let alertVC = alertService.alert()
        
       // let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//
//
//          let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//
//            self.FrozenItemArray.append(newItem)
//            
//            self.saveItem()
//        }
        
//        alert.addAction(action)
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new Item"
//            textField = alertTextField
//        }
        
       // present(alert, animated: true, completion: nil)
        
        //When alert window is opened touch outside cancel action is activated
        self.present(alertVC, animated: true) {
            alertVC.view.superview?.isUserInteractionEnabled = true
            alertVC.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK - Model Manupulatation Methods
    
    func saveItem(){
        do{
            
            try context.save()
            
        }catch{
            print("Erro saving context \(error)")
        }
        
        self.FrozenTableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()){
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
       
        do {
           FrozenItemArray = try context.fetch(request)
        }catch {
            print("Error fetching data from context \(error)")
        }
       
        FrozenTableView.reloadData()
        
        
        
    }
    
    
}// End of Frozen view Controller


//MARK :- Search bar method

extension FrozenListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd]", searchBar.text! )
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
