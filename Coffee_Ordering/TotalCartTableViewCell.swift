//
//  TotalCartTableViewCell.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/30/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class TotalCartTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var TotalValue: UILabel!
    @IBOutlet weak var subtotalValue: UILabel!
    @IBOutlet weak var taxValue: UILabel!
    @IBOutlet weak var totValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
