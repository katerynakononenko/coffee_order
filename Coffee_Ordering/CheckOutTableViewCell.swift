//
//  CheckOutTableViewCell.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/30/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class CheckOutTableViewCell: UITableViewCell {

    @IBAction func checkOut(_ sender: Any) {
        print("Click")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
