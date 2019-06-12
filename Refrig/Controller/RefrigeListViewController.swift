//
//  Refrige.swift
//  Refrig
//
//  Created by The book on 02/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RefrigeListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        table.delegate = self
//        table.dataSource = self
        
    }
    
    @IBOutlet weak var table: UITableView!
    
    
    let refrigeItemArray = ["Oragne", "Apple", "grape"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return refrigeItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "refrigItemCell", for: indexPath)
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "refrigItemCell")
        
        cell.textLabel?.text = refrigeItemArray[indexPath.row]
        
        return cell
        
    }
    
    
}
