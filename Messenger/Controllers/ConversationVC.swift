//
//  ViewController.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import Firebase

enum Keys { static let loginKey = "LOGGED_IN"}

class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    
    }
  
  
    override func viewDidAppear(_ animated: Bool) {
        validateAuth()
    }

    func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil{
                    let loginVC = LoginVC()
                    let navControler = UINavigationController(rootViewController: loginVC)
                    navControler.modalPresentationStyle = .fullScreen
                    present(navControler , animated: false)//false to cancel the delay caused by the animation
        
                }
    }
    
}

