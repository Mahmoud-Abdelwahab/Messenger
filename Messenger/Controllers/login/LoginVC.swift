//
//  LoginVC.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
class LoginVC: UIViewController {
    
    private var loginObserver : NSObjectProtocol?
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
        
        //FB buton delegate
        
        fBLoginButton.delegate = self
        
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
        
        
        /// FBLogin
      
        fBLoginButton.center = view.center
        scrollView.addSubview(fBLoginButton)
        
        //google sign in
        GIDSignIn.sharedInstance()?.presentingViewController = self
        scrollView.addSubview(googlelogInBtn)
        
        
        // Notifications
                                                                        // main thread
        loginObserver =  NotificationCenter.default.addObserver(forName:.didLogInNotifiacation, object: nil, queue: .main, using: {
           [weak self] _ in
        guard let self = self else{return}
          self.dismiss(animated: true)
        // then you need to clean this observer form the memeory  show deinit below
            
        })
        
    }
    
    deinit {
        if let loginObserver = loginObserver {
            NotificationCenter.default.removeObserver(loginObserver)
        }
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
        if #available(iOS 13.0, *) {
            button.backgroundColor                     = .link
        } else {
            // Fallback on earlier versions
        }
        button.layer.cornerRadius                  = 12
        button.layer.masksToBounds                 = true
        button.titleLabel?.font                    = .systemFont(ofSize: 20 , weight : .bold)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let fBLoginButton : FBLoginButton = {
        let fbButton = FBLoginButton()
     
        fbButton.permissions = ["public_profile", "email"]
        //public_profile include firstName and lastName and the email include email
        return fbButton
    }()
    
    private let googlelogInBtn = GIDSignInButton()
    
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
        
        fBLoginButton.frame = CGRect(x: 30, y: loginButton.bottom + 15, width: scrollView.width-60, height: 52)
        
        googlelogInBtn.frame = CGRect(x: 30, y: fBLoginButton.bottom + 15, width: scrollView.width-60, height: 52)
//        fBLoginButton.center = scrollView.center
//        fBLoginButton.frame.origin.y = loginButton.bottom + 20
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
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {[weak self] (authResult, error) in
            guard let self = self else{return}
            
            guard let result = authResult , error == nil else {
                print("Error  in signing in the user ...")
                return
            }
            
            print("loged In successfullly ...")
            self.dismiss(animated: true)
            
        }
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


extension LoginVC : LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
     //no operaation
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard  let token = result?.token?.tokenString else {
            print("User failed to login with Facebook ")
            return
        }
        //we will send this access token to firebase  to get a credentianls
        let credential = FacebookAuthProvider.credential(withAccessToken : token)
        
        FirebaseAuth.Auth.auth().signIn(with: credential) {[weak self] (authResult, error) in
            guard let self = self else{return}
            guard authResult != nil , error == nil else {
                if let error = error {
                    print("faceBook credentials login failed  , MFA may be needed - :\(error)")
                }
                return
            }
            print("successfully logged user in ")
            
            self.dismiss(animated: true)

        }
        
        
    }
    
    
    
}
