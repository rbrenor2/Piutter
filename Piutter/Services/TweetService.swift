//
//  TweetService.swift
//  Piutter
//
//  Created by Breno Ramos on 19/12/21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping( Error?, DatabaseReference) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let values = ["uid": uid, "timestamp": timestamp, "likes": 0, "retweets": 0, "caption": caption] as [String: Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet])->Void) {
        var tweets = [Tweet]()
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            UserService.shared.fetchUser(uid: uid) { user in
                let tweetID = snapshot.key
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
            
        }
        
        
    }
}
