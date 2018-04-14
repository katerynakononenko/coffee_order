//
//  OrderItem.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 3/3/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import Foundation

import SwiftyJSON
import FirebaseFirestore

class OrderItem {
    
    var snapshot: DocumentSnapshot?
    
    var type : String!
    var title : String!
    var imageURL : URL!
    var price : Float!
    
    convenience init?(snapshot: DocumentSnapshot) {
        
        if snapshot.exists {
            if let data = snapshot.data() {
                
                let json = JSON(data)
                self.init(json: json)
                self.snapshot = snapshot
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    
    init(json: JSON) {
        title = json["title"].string
        type = json["type"].string
        price = json["price"].float
    }
    
    var json : [String : Any] {
        var json = [String : Any]()
        json["type"] = type
        json["title"] = title
        json["price"] = price
        json["imageURL"] = imageURL
        return json
    }
    
    static var shopingCartReference : CollectionReference {
        return Firestore.firestore().collection("shoppingCart")
    }
    static var curOrderCartReference : CollectionReference {
        return Firestore.firestore().collection("currentOrder")
    }
    
    func addToShoppingCart() {
        MenuItem.shopingCartReference.addDocument(data: json)
    }
    
    func addToCurrentOrder() {
        MenuItem.curOrderCartReference.addDocument(data: json)
    }
    
    
    func delete() {
        snapshot?.reference.delete()
    }
    
    
}
