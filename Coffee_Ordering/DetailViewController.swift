//
//  DetailViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 1/25/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var item: MenuItem!
    

    @IBOutlet weak var name: UILabel!
    
    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = item.title
    }
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
        item.addToShoppingCart()
        
        UIAlertController.presentOKAlert(from: self, title: item.title, message: "Item was successfully added to the shopping cart.")
        
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
