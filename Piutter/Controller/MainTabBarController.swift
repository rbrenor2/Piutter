//
//  MainTabBarViewController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: K.General.actionButtonImage), for: .normal)
        
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
//        logout()
        fetchUser()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewController()
            configureUI()
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
//        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
//        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configureViewController() {
        
        let feed = templateNavigationControlle(imageName:  K.TabBarImages.feedImageName, viewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let explore = templateNavigationControlle(imageName:  K.TabBarImages.exploreImageName, viewController: ExploreController())
        
        let notifications = templateNavigationControlle(imageName:  K.TabBarImages.notificationsImageName, viewController: NotificationsController())

        let conversations = templateNavigationControlle(imageName:  K.TabBarImages.conversationsImageName, viewController: ConversationsController())
        
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationControlle(imageName: String, viewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.barTintColor = .white
        
        return nav
    }
    

   

}
