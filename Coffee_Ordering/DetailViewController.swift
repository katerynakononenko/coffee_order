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
    
    
  /*  @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: <#T##Any?#>)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = item.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
