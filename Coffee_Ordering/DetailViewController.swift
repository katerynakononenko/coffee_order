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
    
    @IBOutlet weak var itemImg: UIImageView!

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var specialInstructions: UITextField!
    

    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: nil)
    }
    
    
    @IBOutlet weak var addToOrderBtn: UIButton!
    
    @IBAction func addToCartAction(_ sender: Any) {
        let curItem = MenuItem(title: item.title, type: item.type, price: item.price, orderSize: "na", notes : specialInstructions.text)
        
        curItem.addToShoppingCart()
        UIAlertController.presentGoodAlert(from: self, title: item.title, message: "Item was successfully added to the shopping cart.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = item.title
       
        itemPrice.text = String(item.price)
        if (item.imageURL != nil){
            print(item.imageURL!)
            itemImg.downloadedFromD(url: item.imageURL!)
        }
        
        
    }
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
let curItem = MenuItem(title: item.title, type: item.type, price: item.price, orderSize: "na", notes : specialInstructions.text)

        curItem.addToShoppingCart()
UIAlertController.presentGoodAlert(from: self, title: item.title, message: "Item was successfully added to the shopping cart.")
        
    }

}

extension UIAlertController {
    
    static func presentGoodAlert(from vc: UIViewController, title: String, message: String, okHandler: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            okHandler?()
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
}

extension UIImageView {
    func downloadedFromD(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
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
    func downloadedFromD(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}


