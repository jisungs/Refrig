//
//  Data.swift
//  Refrig
//
//  Created by The book Air on 03/07/2019.
//  Copyright © 2019 The book. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
