//
//  FrozenListViewController.swift
//  Refrig
//
//  Created by The book on 02/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import UIKit

class FrozenListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    let frozenItemArray = ["ice", "bumplings", "shrimp"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return frozenItemArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrozenItemCell", for: indexPath)
        
        cell.textLabel?.text = frozenItemArray[indexPath.row]
        
        return cell
        
    }

    
    
    
    
}
