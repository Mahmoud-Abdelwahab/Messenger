//
//  ViewController.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import Firebase
import  JGProgressHUD

enum Keys { static let loginKey = "LOGGED_IN"}

class ConversationVC: UIViewController {

    
    private let spinner  = JGProgressHUD(style: .dark)
    
    private let tableView  : UITableView = {
        let table = UITableView()
        table.isHidden  = true // if u don't have any conversation so don't show tableview
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    private let noConversationLable : UILabel = {
        let lable            = UILabel()
        lable.text           = "No Conversation "
        lable.textAlignment  = .center
        lable.textColor      = .gray
        lable.font           = .systemFont(ofSize : 21 , weight : .medium)
        lable.isHidden       = true
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        view.backgroundColor = .green
        view.addSubview(tableView)
        view.addSubview(noConversationLable)
        setUpTableView()
        fetchConversations()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
  
    
    private func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
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
    
    
    func fetchConversations(){
        tableView.isHidden = false
    }
    
    
    @objc func didTapComposeButton(){
        let newConversationVC = NewConversationVC()
        let navVC = UINavigationController(rootViewController: newConversationVC)
        present(navVC , animated: true)
    }
    
}


extension ConversationVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World "
        cell.accessoryType   =  .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let chatVC = ChatVC()
        chatVC.title = "Jenny Smith"
        chatVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
}
