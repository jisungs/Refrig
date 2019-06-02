//
//  Refrige.swift
//  Refrig
//
//  Created by The book on 02/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import UIKit

class RefrigeListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let refrigeItemArray = ["Oragne", "Apple", "grape"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return refrigeItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "refrigItemCell", for: indexPath)
        
        cell.textLabel?.text = refrigeItemArray[indexPath.row]
        
        return cell
        
    }
    
    
}
