//
//  ViewController.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit

enum Keys { static let loginKey = "LOGGED_IN"}

class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
  
    override func viewDidAppear(_ animated: Bool) {
        
        let isLogedIn = UserDefaults.standard.bool(forKey: Keys.loginKey)
        
        if !isLogedIn{
            let loginVC = LoginVC()
            let navControler = UINavigationController(rootViewController: loginVC)
            navControler.modalPresentationStyle = .fullScreen
            present(navControler , animated: false)//false to cancel the delay caused by the animation
            
        }
    }

}

