//
//  LoginController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: K.Login.logoImage)
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: K.Login.mailImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)

        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: K.Login.passwordImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: K.Login.emailPlaceholder, placeholderColor: .white, textColor: .white, isSecureText: false, autocapitalizeType: .none)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: K.Login.passwordPlaceholder, placeholderColor: .white, textColor: .white, isSecureText: true, autocapitalizeType: .none)
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = Utilities().filledButton(withText: K.Login.signinButtonTitle, backgroundColor: .white, titleColor: .twitterBlue, fontSize: 16)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = Utilities().attributedButton(withText: K.Login.signupButtonTitle1, text2: K.Login.signupButtonTitle2, backgroundColor: .clear, titleColor: .white, fontSize: 13)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .twitterBlue
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton, signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(signupButton)
        signupButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 40, paddingRight: 40)
    }
    
    // MARK: - Selectors
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        let credentials = LoginCredentials(email: email, password: password)
        AuthService.shared.login(credentials: credentials) { data, error in
            
            if error == nil {
                guard let tab = self.view.window?.rootViewController as? MainTabBarController else {return}
                
                tab.authenticateUserAndConfigureUI()
                
                self.dismiss(animated: true, completion: nil)
            } else {
                print("DEBUG: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @objc func handleSignup() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
   
}
