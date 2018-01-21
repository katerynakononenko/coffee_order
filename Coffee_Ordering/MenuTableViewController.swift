//
//  MenuTableViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/20/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit
import FirebaseFirestore
class MenuTableViewController: UITableViewController {

    
    var firebaseMenu : [SectionAndItemsArray] = []
    var listenerRegistration : ListenerRegistration?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let query = Firestore.firestore().collection("menuItems")
        listenerRegistration = query.addSnapshotListener { (snapshot: QuerySnapshot?, error: Error?) in
            
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    
                    self.firebaseMenu.removeAll()
                    var sections = [String : SectionAndItemsArray]()
                    
                    for document in documents {
                        if let item = MenuItem(snapshot: document) {
                            // If there is no type, then put the item into "Other" section
                            let type = item.type ?? "Other"
                            // Try to find an existing section of this type, if no such section exists, then create a new one
                            var array : SectionAndItemsArray = sections[type] ?? SectionAndItemsArray(title: type, menuItems: [])
                            // Add an item to the items array of that section
                            
                            array.menuItems = array.menuItems + [item]
                            // Insert it into the associa
                            sections[type] = array
                        }
                    }
                    
                    
                    
                    self.firebaseMenu = sections.flatMap({ (element: (key: String, value: SectionAndItemsArray)) -> SectionAndItemsArray? in
                        return element.value
                    })
                    
                    print("!!!!!!!!!!!!")
                    print (sections)
                    print("!!!!!!!!!!")
                    
                    self.firebaseMenu.sort(by: { (a: SectionAndItemsArray, b: SectionAndItemsArray) -> Bool in
                        return a.title.compare(b.title) == .orderedAscending
                    })
                    
                    self.tableView.reloadData()
                }
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return firebaseMenu.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        let foodArray = firebaseMenu[section]
        return foodArray.menuItems[0].type
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let foodArray = firebaseMenu[section]
        return foodArray.menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuItemTableViewCell
        let item = firebaseMenu[indexPath.section].menuItems[indexPath.row]
        cell.name?.text = item.title
        let str_price = item.price?.description
        cell.price?.text = str_price
        return cell
    }
    

}
