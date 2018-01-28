//
//  ExpandableHeaderView.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/21/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate{
    func touchSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.touchSection(header: self, section: cell.section)
    }
    
    func myInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate?){
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
 
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
