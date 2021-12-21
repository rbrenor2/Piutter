//
//  Constants.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

struct K {
    
    struct TabBarImages {
        static let feedImageName = "home_unselected"
        static let exploreImageName = "search_unselected"
        static let notificationsImageName = "like_unselected"
        static let conversationsImageName = "ic_mail_outline_white_2x-1"
    }
    
    struct Feed {
        static let twitterLogoImageName = "twitter_logo_blue"
        static let likeButtonImage = "like"
        static let commentButtonImage = "comment"
        static let retweetButtonImage = "retweet"
        static let shareButtonImage = "share"
    }
    
    struct Conversations {
        static let title = "Messages"
    }
    
    struct Explore {
        static let title = "Explore"
    }
    
    struct Notifications {
        static let title = "Notifications"
    }
    
    struct General {
        static let actionButtonImage = "new_tweet"
    }
    
    struct Login {
        static let logoImage = "TwitterLogo"
        static let mailImage = "ic_mail_outline_white_2x-1"
        static let passwordImage = "ic_lock_outline_white_2x"
        static let usernameImage = "ic_person_outline_white_2x"
        static let fullnameImage = "ic_person_outline_white_2x"
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let fullnamePlaceholder = "Full name"
        static let usernamePlaceholder = "Username"
        static let signinButtonTitle = "Login"
        static let signupButtonTitle = "Sign up"
        static let signupButtonTitle1 = "Don't have an account? "
        static let signupButtonTitle2 = "Sign up"
    }
    
    struct Registration {
        static let mailImage = "ic_mail_outline_white_2x-1"
        static let passwordImage = "ic_lock_outline_white_2x"
        static let usernameImage = "ic_person_outline_white_2x"
        static let fullnameImage = "ic_person_outline_white_2x"
        static let addPhotoImage = "plus_photo"
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let fullnamePlaceholder = "Full Name"
        static let usernamePlaceholder = "Username"
        static let signinButtonTitle1 = "Already have an account? "
        static let signinButtonTitle2 = "Sign in"
        static let signupButtonTitle = "Sign up"
    }
}


