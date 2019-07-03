//
//  ViewController.swift
//  Refrig
//
//  Created by The book on 02/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit
import CoreData


class StorageViewController: UIViewController {
    
    
    var category = [Storage]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func action(_ sender: UIButton) {
        performSegue(withIdentifier: "goToItem", sender: nil)
        print(sender.tag)
        
    }
    
    
    //Data Manipulation
    
    func saveCategory(){
        do {
            try context.save()
        }catch{
            print("Error saving category \(error)")
        }
    }
    
    func loadCategory(){
        let request : NSFetchRequest<Storage> = Storage.fetchRequest()
        
        do{
            category = try context.fetch(request)
        } catch {
            print("Error loading category \(error)")
        }
    }
    
    //MARK:- Delegate Method
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // let destinationVC = segue.destination as! FrozenListViewController
        
    }
    
    
    //MARK:- Alert Action
    
    @IBAction func Add(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Storage", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Storage(context: self.context)
            newCategory.storageName = textField.text!
            
            // var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
            let button = UIButton(type: .system) // let preferred over var here
            button.frame = CGRect(x: 100,y: 100,width: 100,height: 100)
            button.backgroundColor = UIColor.green
            button.setTitle(newCategory.storageName, for: UIControl.State.init())
            //button.addTarget(self, action: "Action:", for: UIControl.Event.touchUpInside)
            self.view.addSubview(button)
            
            self.category.append(newCategory)
    
            
            
            self.saveCategory()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add New Category"
        }
        
        present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
 
}

