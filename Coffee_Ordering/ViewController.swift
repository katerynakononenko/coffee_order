//
//  ViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/17/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UITableViewController{
    /*
     input
     [
     menuitem Salads
     menuitem
     menuitem Salads
     menuitem
     ]
     
     */
   
    var menuSections : [String] = ["Coffee & Tea", "Frozen Drinks", "Breakfast", "Salads", "Sandwiches & Wraps", "Flatbread Pizzas", "Sides"]
    var entireMenu : [ExpandableArray] = [
        ExpandableArray(isExpanded: true, menuItems: ["Coffee", "Tea"]),
        ExpandableArray(isExpanded: true, menuItems: ["Smoothie", "Ice"]),
        ExpandableArray(isExpanded: true, menuItems: ["Toast", "Oatmeal"]),
        ExpandableArray(isExpanded: true, menuItems: ["Salad 1", "Salad 2"]),
        ExpandableArray(isExpanded: true, menuItems: ["Sandwich", "Wrap"]),
        ExpandableArray(isExpanded: true, menuItems: ["Pizza 1", "Pizza 2"]),
        ExpandableArray(isExpanded: true, menuItems: ["Fries", "Chips"])
    ]
    var firebaseMenu : [FirebaseExpandableArray] = []
    
    var listenerRegistration : ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuItemCell")
        
        //let query = Firestore.firestore().collection("menuItems").whereField("restaurantId", isEqualTo: "myRestaurant")
        let query = Firestore.firestore().collection("menuItems")
        listenerRegistration = query.addSnapshotListener { (snapshot: QuerySnapshot?, error: Error?) in
            
            if let documents = snapshot?.documents {
                DispatchQueue.main.async {
                    
                    self.firebaseMenu.removeAll()
                    var sections = [String : FirebaseExpandableArray]()
                    
                    for document in documents {
                        if let item = MenuItem(snapshot: document) {
                            // If there is no type, then put the item into "Other" section
                            let type = item.type ?? "Other"
                            // Try to find an existing section of this type, if no such section exists, then create a new one
                            var array : FirebaseExpandableArray = sections[type] ?? FirebaseExpandableArray(isExpanded: true, title: type, menuItems: [])
                            // Add an item to the items array of that section
                            array.menuItems = array.menuItems + [item]
                            // Insert it into the associa
                            sections[type] = array
                        }
                    }
                    
                    self.firebaseMenu = sections.flatMap({ (element: (key: String, value: FirebaseExpandableArray)) -> FirebaseExpandableArray? in
                        return element.value
                    })
                    
                    self.firebaseMenu.sort(by: { (a: FirebaseExpandableArray, b: FirebaseExpandableArray) -> Bool in
                        return a.title.compare(b.title) == .orderedAscending
                    })
                    
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    
/*tableview sections start*/
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerButton = UIButton(type: .system)
        headerButton.setTitle("Close", for: .normal)
        headerButton.setTitleColor(.black, for: .normal)
        headerButton.frame = CGRect(x: 270, y: -10, width:50, height: 50)
        headerView.backgroundColor = UIColor.lightGray
        headerButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        headerButton.tag = section
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 0, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.black
        headerLabel.text = firebaseMenu[section].title
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerButton)
        return headerView
    }
    
    @objc func handleAction(button: UIButton){
        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        for row in entireMenu[section].menuItems.indices{
            indexPaths.append(IndexPath(row: row, section: section))
        }
        let isExpandedNow = entireMenu[section].isExpanded
        entireMenu[section].isExpanded = !isExpandedNow
        
        
        if isExpandedNow{
            tableView.deleteRows(at: indexPaths, with: .fade)
        }else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }

        
       
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return firebaseMenu.count
    }
 /*tableview sections finish*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = firebaseMenu[section]
        if array.isExpanded == false {
            return 0
        }
        return array.menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath)
        let item = firebaseMenu[indexPath.section].menuItems[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }

}

