//
//  TodoItemTableViewCell.swift
//  MyTodoList
//
//  Created by Ahmed Elkhami on 10/19/19.
//  Copyright © 2019 Ahmed Elkhami. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemTextLable: UILabel!
    
    @IBOutlet weak var itemCheckIndicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
