//
//  DrinkDetailViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 3/27/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DrinkDetailViewController: UIViewController {
    var item: MenuItem!
    var itemToOrder: DrinkItem!
    var curSize: String!
    var listenerRegistration : ListenerRegistration?
    var sizeRef: CollectionReference!
    var drinkSizes:[sizeGuide] = []
    var diffSizes: sizeGuide!
    
    @IBOutlet weak var drinkImg: UIImageView!


    @IBOutlet weak var itemDetails: UITextField!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var sizeChanger: UISegmentedControl!
    @IBAction func chooseSize(_ sender: Any) {
        if sizeChanger.selectedSegmentIndex == 0 {
            curSize = "small"
            for it in drinkSizes{
                if(it.title == "Americano"){
                    itemPrice.text = String(it.priceS)
                }
            }
        }else if sizeChanger.selectedSegmentIndex == 1 {
            curSize = "medium"
            for it in drinkSizes{
                if(it.title == "Americano"){
                    itemPrice.text = String(it.priceM)
                }
            }
        }else {
           curSize = "large"
            for it in drinkSizes{
                if(it.title == "Americano"){
                    itemPrice.text = String(it.priceL)
                }
            }
        }
    }
    



    @IBOutlet weak var drinkName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeRef = Firestore.firestore().collection("alternativeSizes")
        let query = sizeGuide.sizesReference
        listenerRegistration = query.addSnapshotListener { [weak self] (snapshot: QuerySnapshot?, error: Error?) in
            
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    
                    self?.drinkSizes.removeAll()
                    
                    for document in documents {
                        if let item = sizeGuide(snapshot: document) {
                        self?.drinkSizes.append(item)
                        
                        }
                        print("Current data: \(document.data())")
                    }
                    
                    //print(self?.drinkSizes)
                    
                }
            }
            
        }
        curSize = "small"
      
        drinkName.text = item.title
  
        itemPrice.text = String(item.price)
        if (item.imageURL != nil){
            print(item.imageURL)
            drinkImg.downloadedFrom(url: item.imageURL!)
        }
        
        // Do any additional setup after loading the view.
        
    }

    @IBAction func addToShoppingCart(_ sender: Any) {
        
        //var curItem = DrinkItem(title: item.title, price: Float(itemPrice.text!), size: curSize, notes: notes)
       // curItem.addToCartOrder()
        let curItem = MenuItem(title: item.title, type: item.type, price: Float(itemPrice.text!), orderSize: curSize, notes: itemDetails.text)
        curItem.addToShoppingCart()
        UIAlertController.presentOKAlert(from: self, title: curItem.title, message: "Item was successfully added to the shopping cart.")

        
    
    }
    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

extension UIAlertController {
    
    static func presentOKAlert(from vc: UIViewController, title: String, message: String, okHandler: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            okHandler?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
   
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

