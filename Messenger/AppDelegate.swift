//
//  AppDelegate.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,GIDSignInDelegate {
    
    
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard  error == nil else {
            if let error = error {
                print("failed to sign in with google ")
            }
            return
        }
        
        guard  let user = user  else {
            return  
        }
        guard let email =  user.profile.email, let firstName = user.profile.givenName , let lastName = user.profile.familyName else {return}
        // check is user exisits
        DataBaseManager.shared.isUserExists(With: email) { (exists) in
            if !exists{
                // insert user
                   UserDefaults.standard.set(email, forKey: "email")
                let chatUser =  ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email)
                DataBaseManager.shared.insertUser(with:chatUser, completion:{success in
                    
                    if success {
                        //upload Image
                        
                        // check first if user has image
                        if user.profile.hasImage {
                            guard let url = user.profile.imageURL(withDimension: 200) else{
                                return
                            }
                            // to get image from google account you need to make network call to get it
                            URLSession.shared.dataTask(with: url , completionHandler: { (data, _, error) in
                                guard let data = data else {
                                    return
                                }
                                let fileName = chatUser.profilePictureFileName
                                StorageManager.shared.uploadProfilPicture(with: data, fileName: fileName , completion : { (result) in
                                    
                                    switch result {
                                    case .success(let downloadURl):
                                        UserDefaults.standard.set(downloadURl, forKey: "profile_picture_URL")
                                        print(downloadURl)
                                        
                                    case .failure(let error): print("Storage manager error : \(error)")
                                    }
                                })
                                
                            }).resume()
                            
                        }
                        
                        
                    }
                })
            }
        }
        
        guard let authentication = user.authentication else {
            print("Missing auth object of google user ")
            return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential , completion: {authResult , error
            in
            guard authResult != nil , error == nil  else{
                print("failed to signed in wiyh google credintials .")
                return
            }
            print("successfully loged in wit Google : \(user) .")
            
            
            // there i need to dismiss the login and go to chat so i used notification here i to file the observr which in the login screen login with google
            //there i will fire notification with the same name which i made in the view extention
            
            NotificationCenter.default.post(name: .didLogInNotifiacation, object: nil)
        })
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("the user is loged out ")
    }
    
    
}


