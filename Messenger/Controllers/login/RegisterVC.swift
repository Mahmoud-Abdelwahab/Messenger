//
//  RegisterVC.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        self.title = "Create Account"
        view.backgroundColor                 = .white
        print(view.frame.origin.y)
        navigationItem.rightBarButtonItem    = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(registerButtonTaped), for: .touchUpInside)
        
        creatDismissKeyboardTapGesture()
        profileImageGesture()// don't forget to enable user interaction haaaaa to make gesture works
      
        
        ///********* when u hit   return button in the keyboard ether it's called done pr next or whatever  i want to perform an action so  i will conform UITextFieldDelegate
        emailField.delegate    = self
        passwordField.delegate = self
        
        //add subView
        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        
        
    }
    
    
    private let scrollView : UIScrollView    = {
        let  scrollView                      = UIScrollView()
        scrollView.clipsToBounds             = true
        scrollView.isUserInteractionEnabled  = true
        return scrollView
    }()
    
    
    private let profileImageView : UIImageView  = {
        let logoImage                        = UIImageView()
        logoImage.image                      = UIImage(named: "add-user")
        logoImage.tintColor                  = .gray
        logoImage.contentMode                = .scaleAspectFit
        logoImage.layer.borderColor          = UIColor.lightGray.cgColor
        logoImage.layer.borderWidth          = 2
        logoImage.layer.masksToBounds        = true
        logoImage.isUserInteractionEnabled   = true // don't forget to enable user interaction haaaaa to make gesture works
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
    
    
    private let firstNameField : UITextField     = {
        let field                            = UITextField()
        field.layer.cornerRadius             = 12
        field.layer.borderWidth              = 1
        field.autocorrectionType             = .no
        field.autocapitalizationType         = .none
        field.returnKeyType                  = .continue
        
        field.backgroundColor                = .white
        field.layer.borderColor              = UIColor.lightGray.cgColor
        field.placeholder                    = "firstName ..."
        
        ///******* these two lines to make padding for text form the left direction
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode                   = .always
        
        return field
    }()
    
    
    private let lastNameField : UITextField     = {
        let field                            = UITextField()
        field.layer.cornerRadius             = 12
        field.layer.borderWidth              = 1
        field.autocorrectionType             = .no
        field.autocapitalizationType         = .none
        field.returnKeyType                  = .continue
        
        field.backgroundColor                = .white
        field.layer.borderColor              = UIColor.lightGray.cgColor
        field.placeholder                    = "LastName "
        
        ///******* these two lines to make padding for text form the left direction
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 0))
        field.leftViewMode                   = .always
        
        return field
    }()
    
    private let loginButton : UIButton             = {
        let button                                 = UIButton()
        button.backgroundColor                     = .systemGreen
        button.layer.cornerRadius                  = 12
        button.layer.masksToBounds                 = true
        button.titleLabel?.font                    = .systemFont(ofSize: 20 , weight : .bold)
        button.setTitle("Register", for: .normal)
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
        profileImageView.layer.cornerRadius = profileImageView.width/2.0 // this to make the image circular corners
        
        firstNameField.frame = CGRect(x: 30, y: profileImageView.bottom + 40, width: scrollView.width-60, height: 52)
        
        lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom + 15, width: scrollView.width-60, height: 52)
        
        
        emailField.frame    = CGRect(x: 30, y: lastNameField.bottom + 15, width: scrollView.width-60, height: 52)
        
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 15, width: scrollView.width-60, height: 52)
        
        loginButton.frame = CGRect(x: 30, y: passwordField.bottom + 15, width: scrollView.width-60, height: 52)
        
        
        
        
    }
    
    
    
    
    @objc func didTapRegister(){
        navigationController?.pushViewController(RegisterVC(), animated: false)
    }
    
    
    @objc func registerButtonTaped(){
        ////**** **********  another way to get rid of the keyboard  ***//////////////////
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameField.text , !firstName.isEmpty , let lastName = lastNameField.text , !lastName.isEmpty, let email = emailField.text , let password = passwordField.text , !email.isEmpty , !password.isEmpty , password.count >= 6 else {
            alertUserLogin()
            return
        }
        
        //FireBase registration
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self](result, error) in
            guard let self = self else {return}
            guard let result = result , error == nil else {
                print("Error creating user ...")
                return
            }
            print(result.user.email)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func alertUserLogin() {
        let alert = UIAlertController(title: "WOoOoPs!", message: "please Enter All Information to create your account 😅 ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (alert) in
            print(" action after Dismissing ...!")
        }))
        present(alert,animated: true)
    }
    
    
    // to dismiss keyboard
    func creatDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func profileImageGesture(){
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(didTapToChangeProfilePic))
//        gestureTap.numberOfTouchesRequired = 1
       //gestureTap.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(gestureTap)
        
        
        
    }
    
    
    @objc func didTapToChangeProfilePic(){
        print("change profile picture ... ")
        presentPhotoActionSheet()
    }
    
}



extension RegisterVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if  textField == emailField {
            
            passwordField.becomeFirstResponder() // when i click retune in the emaile field the curser will go to the password field
            
        }else if (textField == passwordField){
            // when user finish typing his password and hot retun --> done i will log him in
            registerButtonTaped()
        }
        
        return true
    }
}


extension RegisterVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    // this UIImagePickerControllerDelegate delegate get the resuts when user taking a picture or selecting a picture
    // conforming the naigation controler to navigate to take OR choose  Photo
    ///************ don't forget to set the two permisson in the info.plist ******************************//
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // this called when the user take OR select a photo
        // after choosing or taking the image it returen in a dictionary didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{return}
        //editedImage gie us the croped image user has selected ... UIImagePickerController.InfoKey.originalImage
        self.profileImageView.image = selectedImage
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // this called when user cancel the operation
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    //******** this func is mine it dosn't belong to this delegate this func will display the action sheet which appeara in the screen to ask you to choose a pic or take a photo
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to select a picture ",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title:"Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title:"Take Photo",
                                            style: .default,
                                            handler: {[weak self]_ in
                                                  guard let self = self else {return}
                                                self.presentCamera()
                                                
        }))
        actionSheet.addAction(UIAlertAction(title: "choose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                guard let self = self else {return}
                                                self.presentPhotoPicker()
                                            
        }))
        
        present(actionSheet , animated: true)
    }
    
    ///************ custom fuction to make the code more readable
    
    func presentCamera()  {
        
        let cameraVC = UIImagePickerController() // this which the didFinishMediaWithOption takes
        cameraVC.sourceType = .camera
        cameraVC.delegate   = self
        cameraVC.allowsEditing  = true // to allow yu min & max  image and crop image
        present(cameraVC , animated: true)
    }
    
    
    func presentPhotoPicker() {
        let photoPickerVC = UIImagePickerController() // this which the didFinishMediaWithOption takes
        photoPickerVC.sourceType = .photoLibrary
        photoPickerVC.delegate   = self
        photoPickerVC.allowsEditing  = true
        present(photoPickerVC , animated: true)
    }
}
