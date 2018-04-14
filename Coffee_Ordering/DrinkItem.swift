//
//  DrinkItem.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 3/3/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseFirestore

class DrinkItem {
    
    
    var title : String!
    var price : Float!
    var size : String!
    var notes : String!

    init (title: String!, price: Float!, size: String!, notes : String!) {
        self.title = title
        self.price = price
        self.size = size
        self.notes = notes
    }
    
    var json : [String : Any] {
        var json = [String : Any]()
        json["title"] = title
        json["price"] = price
        json["size"] = size
        json["notes"] = notes
        return json
    }
    
 
    static var curOrderCartReference : CollectionReference {
        return Firestore.firestore().collection("currentOrder")
    }
    static var curCartReference : CollectionReference {
        return Firestore.firestore().collection("shoppingCart")
    }
    
    
    func addToCurrentOrder() {
        DrinkItem.curOrderCartReference.addDocument(data: json)
    }
    
    func addToCartOrder() {
        DrinkItem.curCartReference.addDocument(data: json)
    }
    
    
   
    
    
}
