//
//  NewConversationVC.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {

    
    private let spinner = JGProgressHUD()
    private let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search For User ..."
        return search
        
    }()
    
    private let noResultLable : UILabel = {
           let lable            = UILabel()
           lable.text           = "No Results "
           lable.textAlignment  = .center
           lable.textColor      = .gray
           lable.font           = .systemFont(ofSize : 21 , weight : .medium)
           lable.isHidden       = true
           return lable
       }()
    
    private let tableView  : UITableView = {
           let table = UITableView()
           table.isHidden  = true // if u don't have any conversation so don't show tableview
           table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           return table
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        // search bar
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
        
        
        // compose keyboard
        searchBar.becomeFirstResponder()
    }
    

  
   @objc private func dismissSelf()  {
        dismiss(animated: true, completion: nil)
    }

}


extension NewConversationVC : UISearchBarDelegate {
    
}
