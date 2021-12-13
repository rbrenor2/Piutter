//
//  Utilities.swift
//  Piutter
//
//  Created by Breno Ramos on 03/12/21.
//

import UIKit

class Utilities {
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        
        let view: UIView = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        
        view.addSubview(iv)
        
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)

        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)

        return view
    }
    
    func textField(withPlaceholder placeholder: String, placeholderColor: UIColor, textColor: UIColor, isSecureText: Bool, autocapitalizeType:  UITextAutocapitalizationType) -> UITextField {
        
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.textColor = textColor
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.isSecureTextEntry = isSecureText
        tf.autocapitalizationType = autocapitalizeType

        return tf
    }
    
    func filledButton(withText text: String, backgroundColor: UIColor, titleColor: UIColor, fontSize: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        return button
    }
    
    func attributedButton(withText text1: String, text2: String, backgroundColor: UIColor, titleColor: UIColor, fontSize: CGFloat) -> UIButton {
        
        let attributedTitle = NSMutableAttributedString(string: text1, attributes: [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        
        attributedTitle.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]))
        
        let button = UIButton(type: .system)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        
        return button
    }
}
