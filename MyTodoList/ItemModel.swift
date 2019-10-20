//
//  ItemModel.swift
//  MyTodoList
//
//  Created by Ahmed Elkhami on 10/19/19.
//  Copyright © 2019 Ahmed Elkhami. All rights reserved.
//

import Foundation

class ItemModel: NSObject{
    
    var itemText: String?
    var checked: Bool = false
    
    func switchCheck() {
        checked = !checked
    }
}
