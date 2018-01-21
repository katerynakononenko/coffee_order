//
//  ExpandableArray.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/17/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import Foundation

struct ExpandableArray{
    var isExpanded: Bool
    var menuItems = [String]()
}

struct SectionAndItemsArray {
    var title : String
    var menuItems = [MenuItem]()
}

struct FirebaseExpandableArray {
    var isExpanded: Bool
    var title : String
    var menuItems = [MenuItem]()
}
