//
//  UserService.swift
//  Piutter
//
//  Created by Breno Ramos on 08/12/21.
//

import FirebaseDatabase
import FirebaseAuth

class UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, withCompletion completion: @escaping(User) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
        }
    }
}
