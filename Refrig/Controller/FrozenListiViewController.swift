//
//  FrozenListiViewController.swift
//  Refrig
//
//  Created by The book Air on 03/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit
import RealmSwift


class FrozenListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
  
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //prepare to reload tableview to another viewcontroller
        NotificationCenter.default.addObserver(self, selector: #selector(loadView), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPreesed(sender:)))
        self.navigationItem.rightBarButtonItem = add
        add.tintColor = UIColor.white
        
    }
    
    //Define what tableView reload
    func loadList(notification: NSNotification){
        //load data here
        self.FrozenTableView.reloadData()
    }

    

    //MARK:- Alert service property
    let alertService = AlertService()
    
    var selectedStorage : Storage? {
        didSet{
           // loadItems()
        }
    }
    
    @IBOutlet weak var FrozenTableView: UITableView!
    
    
    var ItemArray : Results<Item>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    //MARK:- When touch outside of keyboard it reset the position
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    //MARK:- when Retrun input occuerd the keyboard is reset
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ItemArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "FrozenItemCell", for: indexPath)
        
         let item = ItemArray?[indexPath.row]
        
        cell.textLabel?.text = item?.title ?? "There is no items in the storage"
        
        //Teneary Operation
        // value = condition ? value 1 : value 2 
        cell.accessoryType = item?.done ?? false ? .checkmark : .none
        
        return cell
    
    }
    
    //MARK: - TableView Delegate Method
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(FrozenItemArray[indexPath.row])
        
        //Toggling data modals property
        ItemArray?[indexPath.row].done = !ItemArray?[indexPath.row].done
        
       //saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Remove cell using swipe action
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //self.context.delete(FrozenItemArray[indexPath.row])
            ItemArray.remove(at: indexPath.row)
           // save(item : Item)
            
        }
    }
    
    //MARK: - Add new Item
    
    @objc func addButtonPreesed(sender: UIBarButtonItem){
        
        let alertVC = alertService.alert()
        
        
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
    
    //MARK: - Model Manupulatation Methods
    
    func save(item : Item){
        do{
            
            try realm.write {
                realm.add(item)
            }
            
        }catch{
            print("Erro saving context \(error)")
        }
        
        self.FrozenTableView.reloadData()
    }
    
//    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest()){
//       // let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//           FrozenItemArray = try context.fetch(request)
//        }catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        FrozenTableView.reloadData()
//
    
        
   // }
    
    
}// End of Frozen view Controller


//MARK :- Search bar method

//extension FrozenListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd]", searchBar.text! )
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
//
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            DispatchQueue.main.async {
//               searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//
//}
