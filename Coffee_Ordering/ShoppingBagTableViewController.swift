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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return menuItems.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuItemTableViewCell
        let item = menuItems[indexPath.row]
        cell.name?.text = item.title
        let str_price = item.price?.description
        cell.price?.text = str_price
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
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
                    item.delete()
                }
            })
        ]
    }
}
