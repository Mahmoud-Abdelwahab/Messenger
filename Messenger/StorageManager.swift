//
//  StorageManager.swift
//  Messenger
//
//  Created by kasper on 7/2/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    private init(){}
    
    // function that take image as a byte and the name which should be written to i will name the image with  user email.png
    /*
     /images/ma_hn2013_live_com_profile_picture
     */
    ///uploade image to firestorage and return completion with utl string to download
    
    ///** type alias used to store  block of code with single lable
    public typealias UploadPictureCompletion = (Result<String ,Error>) -> Void
    public func uploadProfilPicture(with data : Data , fileName : String ,completion : @escaping UploadPictureCompletion ){
        storage.child("images/\(fileName)").putData(data , metadata: nil , completion: {metadata, error in
            guard error == nil else {
                //failed
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            // here photo uploaded successfully now i want to get the photo url
            let reference = self.storage.child("images/\(fileName)").downloadURL { (url, error) in
                guard let url = url else{
                    print("can't get photo url back 😭")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                // here i get the picture url successfully
                
                print("the usr is : \(url.absoluteString)")
                completion(.success(url.absoluteString))
            }
            
        })
        
    }
    
    
    //  our own error
    public  enum StorageErrors : Error{
        case   failedToUpload
        case    failedToGetDownloadUrl
    }
    
    // this finction download the image based on the url i send to it
  
    
    public typealias downloadURLCompletion = (Result<URL ,Error>) -> Void
    
     public func downloadURL(for path : String ,completion : @escaping downloadURLCompletion) {
        let reference = storage.child(path)
        reference.downloadURL(completion: { (url , error) in
            guard let url = url , error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        })
    }
}
