//
//  ItemDetailViewController.swift
//  MyTodoList
//
//  Created by Ahmed Elkhami on 10/18/19.
//  Copyright © 2019 Ahmed Elkhami. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func onAddingNewItem(_ delegate: ItemDetailViewController, itemText: String)
    func onEditingItem(_ delegate: ItemDetailViewController, item: ItemModel)
}

class ItemDetailViewController: UITableViewController {
  
    @IBOutlet weak var textEditor: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
             doneButton.isEnabled = true
            textEditor.text = item.itemText
        }else {
            title = "New Item"
        }
        
        navigationItem.largeTitleDisplayMode = .never
    }

    
    override func viewWillAppear(_ animated: Bool) {
        textEditor.becomeFirstResponder()
    }
    
    @IBAction func onDoneClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        if let item = itemToEdit{
            item.itemText = textEditor.text
            delegate?.onEditingItem(self, item: item)
        }else{
        delegate?.onAddingNewItem(self, itemText: textEditor.text!)
        }
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    

    

}

extension ItemDetailViewController: UITextFieldDelegate{
    
    //when clicking return on keyboard hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textEditor.resignFirstResponder()
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText  = textField.text, let stringRange = Range(range, in: oldText) else{
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty{
            doneButton.isEnabled = false
        }else {
            doneButton.isEnabled = true
        }
        
        return true
    }
    
}
