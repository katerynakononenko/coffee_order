//
//  sizeGuide.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 4/16/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import Foundation
import Foundation
import SwiftyJSON
import FirebaseFirestore

class sizeGuide {
var snapshot: DocumentSnapshot?

var type : String!
var title : String!
var imageURL : URL!
var priceI : Float!
var priceS : Float!
var priceM : Float!
var priceL : Float!

//var orderTimestamp: TimeInterval?
//var orderSize: String?
//var notes : String?

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
    priceS = json["priceS"].float
    priceM = json["priceM"].float
    priceL = json["priceL"].float
    priceI = json["priceI"].float

}

var json : [String : Any] {
    var json = [String : Any]()
    json["title"] = title
    json["priceS"] = priceS
    json["priceM"] = priceM
    json["priceL"] = priceL
    json["priceI"] = priceI
    return json
}

    static var sizesReference : CollectionReference {
        return Firestore.firestore().collection("alternativeSizes")
    }

}
