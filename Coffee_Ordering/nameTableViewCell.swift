//
//  nameTableViewCell.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 4/16/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class nameTableViewCell: UITableViewCell {

    var orderName: String =  "No Name"
    @IBOutlet weak var nameField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        orderName = nameField.text!
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
