//
//  FeedController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit


class FeedController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: K.Feed.twitterLogoImageName))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}


