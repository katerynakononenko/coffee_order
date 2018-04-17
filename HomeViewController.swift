//
//  HomeViewController.swift
//  Coffee_Ordering
//
//  Created by Kateryna Kononenko on 4/11/18.
//  Copyright © 2018 Kateryna Kononenko. All rights reserved.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {

    @IBOutlet weak var greetingLable: UILabel!
    @IBOutlet weak var bgdImg: UIImageView!
    var newStr: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bgdImg.image = UIImage(named: "logohome")!
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        print(hour)
        if (hour < 12){
            greetingLable.text = "Good Morning!"
        }else if(hour < 18){
             greetingLable.text = "Good Afternoon!"
        }else{
             greetingLable.text = "Good Evening!"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestPushNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .alert]) { (success, error) in
            guard success else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    


}
