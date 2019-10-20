//
//  ViewController.swift
//  MyTodoList
//
//  Created by Ahmed Elkhami on 10/18/19.
//  Copyright © 2019 Ahmed Elkhami. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoList = ItemsList()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "To do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    //get list count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.todoItems.count
    }
    
    //draw items and set the UI
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoItemTableViewCell
        
        let item = todoList.todoItems[indexPath.row]
        
        initCellView(cell: cell, item: item)
        
        return cell
    }
    
    //handle on item click
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing{
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        let item = todoList.todoItems[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath){
            refreshCellview(cell: cell as! TodoItemTableViewCell, item: item)
        }
    }
    
    //swipe to delte items
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        todoList.deleteItem(index: indexPath.row)
        tableView.reloadData()
    }
    
    //on edit mode: replace items
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = todoList.todoItems[sourceIndexPath.row]
        
        todoList.replaceItems(item: item, to: destinationIndexPath.row)
    }
    
    @IBAction func addItemButton(_ sender: Any) {
    }
    

    @IBAction func deleteButton(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows{
        var itemsToBeDeleted = [ItemModel]()
            for indexPath in selectedRows{
                itemsToBeDeleted.append(todoList.todoItems[indexPath.row])
            }
            todoList.deleteItems(items: itemsToBeDeleted)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func initCellView(cell: TodoItemTableViewCell, item: ItemModel){
        
        if let lable = cell.itemTextLable {
            lable.text = item.itemText
        }
        
        if let indicator = cell.itemCheckIndicator{
            if item.checked {
                indicator.isHidden = false
            }else {
                indicator.isHidden = true
            }
        }
        
    }
    
    func refreshCellview(cell: TodoItemTableViewCell, item: ItemModel){
        
        item.switchCheck()
        
        if let indicator = cell.itemCheckIndicator{
            if item.checked {
                indicator.isHidden = false
            }else {
                indicator.isHidden = true
            }
        }
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetails"{
            let controller = segue.destination as? ItemDetailViewController
            controller?.delegate = self
        }else if segue.identifier == "editItem"{
            let controller = segue.destination as? ItemDetailViewController
            controller?.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller?.itemToEdit = todoList.todoItems[indexPath.row]
            }
            
        }
    }
    
}

extension TodoListViewController: ItemDetailViewControllerDelegate {
    func onEditingItem(_ delegate: ItemDetailViewController, item: ItemModel) {
        
        if let index = todoList.todoItems.firstIndex(of: item){
            todoList.updateItem(updatedItem: item, index: index)
            tableView.reloadData()
        }
        
    }
    
    func onAddingNewItem(_ delegate: ItemDetailViewController, itemText: String) {
        todoList.createItem(todoValue: itemText)
        tableView.reloadData()
    }
    
}

