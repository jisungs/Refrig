//
//  FrozenListiViewController.swift
//  Refrig
//
//  Created by The book Air on 03/06/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import UIKit


class FrozenListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var FrozenTableView: UITableView!
    
    let FrozenItemArray = ["Ice", "shrimp", "dumpings"]
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        FrozenTableView.delegate = self
        FrozenTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FrozenItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrozenItemCell", for: indexPath)
        
        cell.textLabel?.text = FrozenItemArray[indexPath.row]
        
        return cell
        
        
    }
    
    
}
