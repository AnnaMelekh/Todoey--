//
//  Category.swift
//  Todoey
//
//  Created by Anna Melekhina on 06.12.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
