//
//  FeedController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit
import SDWebImage


class FeedController: UIViewController {
    // MARK: - Properties
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let logoImageView = UIImageView(image: UIImage(named: K.Feed.twitterLogoImageName))
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
        
        
    }
    
    func configureLeftBarButton(){
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}


