//
//  HomeViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 2/8/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  
    @IBOutlet weak var menuBtn: UIBarButtonItem!
   
    @IBOutlet var screenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "home")
        screenView.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
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
