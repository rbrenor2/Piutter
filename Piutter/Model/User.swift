//
//  User.swift
//  Piutter
//
//  Created by Breno Ramos on 08/12/21.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        email = dictionary["email"] as? String ?? ""
        fullname = dictionary["fullname"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
        if let imageUrl = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: imageUrl) else {return}
            self.profileImageUrl = url
        }
    }
}
