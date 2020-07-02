//
//  ProfileVC.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import  FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
class ProfileVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Log Out"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //registering the default tableview cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
}

extension ProfileVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text              = data[indexPath.row]
        cell.textLabel?.textAlignment     = .center
        cell.textLabel?.textColor         = .red
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {[weak self] _ in
            
            guard let strongSelf = self else{return}
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let loginVC = LoginVC()
                let navControler = UINavigationController(rootViewController: loginVC)
                navControler.modalPresentationStyle = .fullScreen
                strongSelf.present(navControler , animated: false)//false to cancel the delay caused by the animation
                
                
            } catch  {
                print("failed to logOut ")
            }
            
            
            //FBlog out
            
            // google sign out
            GIDSignIn.sharedInstance()?.signOut()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet , animated: true)
        
        
        
    }
    
    
    
}
