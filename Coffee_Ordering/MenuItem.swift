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
    
    var price : Float!

    var orderTimestamp: TimeInterval?
    var imageURL : URL?
    var orderSize: String?
    var notes : String?
    var orderName : String?
    
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
    
    init (title: String!, type: String!, price: Float!, orderSize: String!, notes : String!) {
        self.title = title
        self.type = type
        self.price = price
        self.orderSize = orderSize
        self.notes = notes
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
        if let imageURL = imageURL{
            json["imageURL"] = imageURL
        }
        if let orderSize = orderSize {
            json["orderSize"] = orderSize
        }
        if let orderTimestamp = orderTimestamp {
            json["orderTimestamp"] = orderTimestamp
        }
        
        if let notes = notes {
            json["notes"] = notes
        }
        if let orderName = orderName {
            json["orderName"] = orderName
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
