//
//  MenuItem.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/20/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import Foundation
import SwiftyJSON
import FirebaseFirestore

/*
 1) Data sits in Firebase
 2) Fetch the data form the Firebase - JSON
 */

class MenuItem {
    
    var snapshot: DocumentSnapshot?
    
    var type : String!
    var title : String!
    var imageURL : URL!
    var price : Float!

    var orderTimestamp: TimeInterval?
    var orderSize: String?
    var notes : String?
    
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
        imageURL = URL(string: json["imageURL"].stringValue)
        orderTimestamp = json["orderTimestamp"].double
        orderSize = json["orderSize"].string
        notes = json["notes"].string
    }
    
    var json : [String : Any] {
        var json = [String : Any]()
        json["type"] = type
        json["title"] = title
        json["price"] = price
        json["imageURL"] = imageURL
        if let orderSize = orderSize {
            json["orderSize"] = orderSize
        }
        if let orderTimestamp = orderTimestamp {
            json["orderTimestamp"] = orderTimestamp
        }
        
        if let notes = notes {
            json["notes"] = notes
        }
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
