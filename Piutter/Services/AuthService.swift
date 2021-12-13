//
//  AuthService.swift
//  Piutter
//
//  Created by Breno Ramos on 05/12/21.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

struct AuthCredentials {
    let profileImage: UIImage
    let email: String
    let password: String
    let fullname: String
    let username: String
}

struct LoginCredentials {
    let email: String
    let password: String
}

class AuthService {
    static let shared = AuthService()
    
    func login(credentials: LoginCredentials, completion: @escaping(AuthDataResult?, Error?)->Void) {
        Auth.auth().signIn(withEmail: credentials.email, password: credentials.password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference)->Void) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil, completion: {(meta, error) in
            if error == nil {
                storageRef.downloadURL(completion: { (url, error) in
                    guard let url = url?.absoluteString else { return }
                    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password, completion: {(result, error) in
                        
                        if let error = error {
                            print("DEBUG: \(error)")
                            return
                        }
                        
                        guard let uid = result?.user.uid else {return}
                        
                        let values = ["email": credentials.email, "username": credentials.username, "fullname": credentials.fullname, "profileImageUrl": url]

                        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    })
                })
            } else {
                print("DEBUG: \(String(describing: error?.localizedDescription))")
            }
            
        })
    }
}
