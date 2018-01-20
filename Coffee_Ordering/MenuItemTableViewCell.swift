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
    var price: UILabel!
    var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    init(frame: CGRect, title: String) {
        super.init(style: .default, reuseIdentifier: "MenuItemCell")
        
        name.frame = CGRect(x: -100, y: 10, width:100.0, height: 40)
        name.textColor = .black
        //img?.frame = CGRect(x: 5, y: 5, width:100, height: 200)
        
        addSubview(name)
        //addSubview(img)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}
