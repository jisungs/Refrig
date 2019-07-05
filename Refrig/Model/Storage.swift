//
//  Storage.swift
//  Refrig
//
//  Created by The book Air on 05/07/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import RealmSwift

class Storage: Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()

}
