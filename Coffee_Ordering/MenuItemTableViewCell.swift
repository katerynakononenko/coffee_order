//
//  MenuItemTableViewCell.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/20/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    var img: UIImageView!

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
