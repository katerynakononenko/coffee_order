//
//  DrinkDetailViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 3/27/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class DrinkDetailViewController: UIViewController {
    var item: MenuItem!
    var itemToOrder: DrinkItem!
    var curSize: String!
    


    @IBOutlet weak var itemDetails: UITextField!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var sizeChanger: UISegmentedControl!
    @IBAction func chooseSize(_ sender: Any) {
        if sizeChanger.selectedSegmentIndex == 0 {
            curSize = "small"
        }else if sizeChanger.selectedSegmentIndex == 1 {
            curSize = "medium"
        }else {
           curSize = "large"
        }
    }
    



    @IBOutlet weak var drinkName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        curSize = "small"
        drinkName.text = item.title
        itemPrice.text = String(item.price)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addToShoppingCart(_ sender: Any) {
        var notes = itemDetails.text
        var curItem = DrinkItem(title: item.title, price:item.price, size: curSize, notes: notes)
        curItem.addToCartOrder()
        
    }
    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
