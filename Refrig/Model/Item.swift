//
//  Item.swift
//  Refrig
//
//  Created by The book Air on 05/07/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var exDate : Date  = Date()
    
    var parentStorage = LinkingObjects(fromType: Storage.self, property: "items")
}
