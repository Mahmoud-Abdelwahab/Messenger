//
//  LoginVC.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        view.backgroundColor                 = .white
        print(view.frame.origin.y)
        navigationItem.rightBarButtonItem    = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(loginButtonTaped), for: .touchUpInside)
        
        creatDismissKeyboardTapGesture()
        
        ///********* when u hit   return button in the keyboard ether it's called done pr next or whatever  i want to perform an action so  i will conform UITextFieldDelegate
        emailField.delegate    = self
        passwordField.delegate = self
        
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
        
    }
    
    
    private let scrollView : UIScrollView    = {
        let  scrollView                      = UIScrollView()
        scrollView.clipsToBounds             = true
        return scrollView
    }()
    
    
    private let profileImageView : UIImageView  = {
        let logoImage                        = UIImageView()
        logoImage.image                      = UIImage(named: "messenger-logo")
        logoImage.contentMode                = .scaleAspectFit
        return logoImage
    }()
    
    
    private let emailField : UITextField     = {
        let field                            = UITextField()
        field.layer.cornerRadius             = 12
        field.layer.borderWidth              = 1
        field.autocorrectionType             = .no
        field.autocapitalizationType         = .none
        field.returnKeyType                  = .continue
        
        field.backgroundColor                = .white
        field.layer.borderColor              = UIColor.lightGray.cgColor
        field.placeholder                    = "Email address"
        
        ///******* these two lines to make padding for text form the left direction
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode                   = .always
        
        return field
    }()
    
    
    private let passwordField : UITextField    = {
        let field                            = UITextField()
        field.layer.cornerRadius             = 12
        field.layer.borderWidth              = 1
        field.autocorrectionType             = .no
        field.autocapitalizationType         = .none
        field.returnKeyType                  = .done
        
        field.backgroundColor                = .white
        field.layer.borderColor              = UIColor.lightGray.cgColor
        field.placeholder                    = "Password ..."
        field.isSecureTextEntry                = true
        ///******* these two lines to make padding for text form the left direction
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode                   = .always
        
        return field
    }()
    
    
    private let loginButton : UIButton             = {
        let button                                 = UIButton()
        button.backgroundColor                     = .gray
        button.layer.cornerRadius                  = 12
        button.layer.masksToBounds                 = true
        button.titleLabel?.font                    = .systemFont(ofSize: 20 , weight : .bold)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    ///******************** this is anoher way to make aconstraints u can use  constraints it's better i guess NSLayoutConstariants.activate([]) and  don't forget to put translatesAutoresizingMaskIntoConstraints = false
    // in the func u can give the frame for the view elements
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame    = view.bounds
        let size = scrollView.width/3
        profileImageView.frame = CGRect(x: size , y: 20, width: size, height: size)
        
        emailField.frame    = CGRect(x: 30, y: profileImageView.bottom + 40, width: scrollView.width-60, height: 52)
        
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 15, width: scrollView.width-60, height: 52)
        
        loginButton.frame = CGRect(x: 30, y: passwordField.bottom + 15, width: scrollView.width-60, height: 52)
        
        
    }
    
    @objc func didTapRegister(){
        navigationController?.pushViewController(RegisterVC(), animated: false)
    }
    
    
    @objc func loginButtonTaped(){
        ////**** **********  another way to get rid of the keyboard  ***//////////////////
                     emailField.resignFirstResponder()
                     passwordField.resignFirstResponder()
        guard  let email = emailField.text , let password = passwordField.text , !email.isEmpty , !password.isEmpty else {
            alertUserLogin()
            return
        }
        
        //FireBase login
        
    }
    
    
    // to dismiss keyboard
       func creatDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
       }
    
    
    func alertUserLogin() {
        let alert = UIAlertController(title: "WOoOoPs!", message: "please Enter All Information to Login 😅", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (alert) in
            print(" action after Dismissing ...!")
        }))
        
        present(alert,animated: true)
    }
    
    
}



extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if  textField == emailField {
            
            passwordField.becomeFirstResponder() // when i click retune in the emaile field the curser will go to the password field
            
        }else if (textField == passwordField){
            // when user finish typing his password and hot retun --> done i will log him in
            loginButtonTaped()
        }
        
        return true
    }
}
