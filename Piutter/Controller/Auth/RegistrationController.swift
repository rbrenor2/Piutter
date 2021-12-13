//
//  RegistrationController.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: K.Registration.addPhotoImage)
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 128/2
        button.layer.masksToBounds = true
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: K.Registration.mailImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)

        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: K.Registration.passwordImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let image = UIImage(named: K.Login.fullnameImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: fullnameTextField)
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = UIImage(named: K.Login.usernameImage)
        let view = Utilities().inputContainerView(withImage: image!, textField: usernameTextField)
        
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
    
    private let fullnameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: K.Login.fullnamePlaceholder, placeholderColor: .white, textColor: .white, isSecureText: false, autocapitalizeType: .words)
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: K.Login.usernamePlaceholder, placeholderColor: .white, textColor: .white, isSecureText: false, autocapitalizeType: .none)
        return tf
    }()
    
    private let signupButton: UIButton = {
        let button = Utilities().filledButton(withText: K.Login.signupButtonTitle, backgroundColor: .white, titleColor: .twitterBlue, fontSize: 16)
        
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = Utilities().attributedButton(withText: K.Registration.signinButtonTitle1, text2: K.Registration.signinButtonTitle2, backgroundColor: .clear, titleColor: .white, fontSize: 13)
        button.addTarget(self, action: #selector(handleSignin), for: .touchUpInside)
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
        navigationController?.isNavigationBarHidden = true
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, signupButton])
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,  right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(loginButton)
        loginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingLeft: 40, paddingRight: 40)
    }
    
    // MARK: - Selectors
    @objc func handleSignup() {
        guard let profileImage = profileImage else {
            print("DEBUG: Select profile Image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }

        let credentials = AuthCredentials(profileImage: profileImage, email: email, password: username, fullname: password, username: fullname)
        AuthService().registerUser(credentials: credentials) { error, DB_REF in
            
            print("DEBUG: ERROR \(String(describing: error?.localizedDescription))")
            
            if error == nil {
                guard let tab = self.view.window?.rootViewController as? MainTabBarController else {return}
                
                tab.authenticateUserAndConfigureUI()
                
                self.dismiss(animated: true, completion: nil)
            } else {
                print("DEBUG: not registered")

            }
        }
    }
    
    
    @objc func handleSignin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
}

// MARK: - Delegates
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3

        dismiss(animated: true, completion: nil)
    }
}
