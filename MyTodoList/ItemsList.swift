//
//  ItemsList.swift
//  MyTodoList
//
//  Created by Ahmed Elkhami on 10/19/19.
//  Copyright © 2019 Ahmed Elkhami. All rights reserved.
//

import Foundation

class ItemsList{
    
    let item1 = ItemModel()
    let item2 = ItemModel()
    let item3 = ItemModel()
    
    var todoItems: Array<ItemModel> = []
    
    init() {

        item1.itemText = "Apple"
        item2.itemText = "Banana"
        item3.itemText = "Orange"
        
        createItems()
    }
    
    
    func createItems(){
        todoItems.append(item1)
        todoItems.append(item2)
        todoItems.append(item3)
    }
    
    func createItem(todoValue: String){
        let todoItem = ItemModel()
        todoItem.itemText = todoValue
        todoItems.append(todoItem)
    }
    
    func updateItem(updatedItem: ItemModel, index: Int){
        todoItems[index] = updatedItem
    }
    
    func replaceItems(item: ItemModel,to destinationIndex: Int){
        guard let currentIndex = todoItems.firstIndex(of: item) else {
            return
        }
        
        todoItems.remove(at: currentIndex)
        todoItems.insert(item, at: destinationIndex)
    }
    
    func deleteItem(index: Int){
        todoItems.remove(at: index)
    }
    
    func deleteItems(items: [ItemModel]){
        for item in items {
            if let index = todoItems.firstIndex(of: item){
                todoItems.remove(at: index)
            }
        }
    }
    

        
//    var todoItems: Array<ItemModel> {
//        get{
//            let item1 = ItemModel()
//            item1.itemText = "Apple"
//            let item2 = ItemModel()
//            item2.itemText = "Banana"
//            let item3 = ItemModel()
//            item3.itemText = "Orange"
//
//            return [item1, item2, item3]
//        }
//    }
    
    
}
