//
//  HomeViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 4/11/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bgdImg: UIImageView!
    var newStr: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bgdImg.image = UIImage(named: "homebgd")!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
