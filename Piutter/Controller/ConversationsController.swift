//
//  ConversationsController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit


class ConversationsController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = K.Conversations.title
    }
    
}
