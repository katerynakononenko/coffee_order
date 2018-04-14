//
//  ShoppingBagTableViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/28/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit
import FirebaseFirestore


class ShoppingBagTableViewController: UITableViewController {
  
 
    
    var menuItems : [MenuItem] = []
    var listenerRegistration : ListenerRegistration?
    var orderRef: CollectionReference!
    var subtotal: Float = 0.0
    var curOrder : [MenuItem] = []

    @IBAction func checkOutBtn(_ sender: Any) {
        
        let timestamp = Date().timeIntervalSince1970
        for item in menuItems{
            item.orderTimestamp = timestamp
            item.addToCurrentOrder()
        }
        
         UIAlertController.presentOKAlert(from: self, title: "Thank you :)", message: "Your order was sent over!")
        menuItems.removeAll()
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderRef = Firestore.firestore().collection("currentOrder")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        
        
        let query = MenuItem.shopingCartReference
        listenerRegistration = query.addSnapshotListener { [weak self] (snapshot: QuerySnapshot?, error: Error?) in
            
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    
                    self?.menuItems.removeAll()
                    
                    for document in documents {
                        if let item = MenuItem(snapshot: document) {
                            self?.menuItems.append(item)
                        }
                    }
                    
                    self?.tableView.reloadData()
                  
                }
            }
            
        }
      
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count + 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == menuItems.count {
            return 100
        } else {
            return 44
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if indexPath.row == menuItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCartTableViewCell", for: indexPath) as! TotalCartTableViewCell
        subtotal = 0
        for it in menuItems {
                subtotal += it.price
                print(subtotal)
            }
            cell.subtotalValue.text = String(subtotal)
            cell.taxValue.text = String(subtotal*0.1)
            cell.totValue.text = String(subtotal*1.1)
            return cell
         } else if indexPath.row == menuItems.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutTableViewCell", for: indexPath) as! CheckOutTableViewCell
        
            return cell
       }else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuItemTableViewCell
         let item = menuItems[indexPath.row]
         cell.name.text = item.title
         let str_price = item.price.description
         cell.price?.text = str_price
         return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        
        if (indexPath.row >= menuItems.count){
            return
        }
        let item = menuItems[indexPath.row]
        print(item.title)
        
        performSegue(withIdentifier: "toDetailWeGo", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailWeGo", let vc = segue.destination as? DetailViewController, let item = sender as? MenuItem {
            vc.item = item
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .destructive, title: "Remove from Shopping Cart", handler: { [weak self] (action: UITableViewRowAction, indexPath: IndexPath) in
                
                if let item = self?.menuItems[indexPath.row] {
                    self?.subtotal -= item.price
                    item.delete()
                }
                

            })
        ]
    }
}

extension UIAlertController {
    
    static func presentOrderPlacedAlert(from vc: UITableViewController, title: String, message: String, okHandler: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            okHandler?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
