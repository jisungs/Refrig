//
//  FrozenListViewController.swift
//  Refrig
//
//  Created by The book on 02/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import UIKit

class FrozenListViewController:UITableViewController  {
    
    let frozenItemArray = ["ice", "dumplings", "shrimps"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frozenItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "frozenItem", for: indexPath)
        
        cell.textLabel?.text = frozenItemArray[indexPath.row]
        
        return cell
    }
}
