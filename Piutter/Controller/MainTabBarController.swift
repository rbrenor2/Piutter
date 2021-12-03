//
//  MainTabBarViewController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
    }
    
    
    // MARK: - Helpers
    
    func configureViewController() {
        
        let feed = templateNavigationControlle(imageName:  K.TabBarImages.feedImageName, viewController: FeedController())
        
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
