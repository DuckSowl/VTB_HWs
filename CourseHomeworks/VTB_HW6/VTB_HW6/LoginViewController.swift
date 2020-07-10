//
//  LoginViewController.swift
//  VTB_HW6
//
//  Created by Anton Tolstov on 10.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var loginTextField = textField(with: Constant.loginPlaceholder)
    private lazy var passswordTextField = textField(with: Constant.passwordPlaceholder)
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        if let user = User() {
            signIn(with: user)
        } else {
            view = UIView()
            view.backgroundColor = .white
            
            setupTextFields()
            setupLoginButton()
        }
    }
    
    // MARK: - View Setup
    
    private func setupTextFields() {
        loginTextField.becomeFirstResponder()
        passswordTextField.isSecureTextEntry = true
        
        let stackView = UIStackView(arrangedSubviews: [loginTextField,
                                                       passswordTextField])
        stackView.axis = .vertical
        stackView.spacing = Constant.textFieldsSpacing
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constant.sideAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Constant.sideAnchor),
        ])
    }
    
    private func setupLoginButton() {
        let button = UIButton()
        button.setTitle(Constant.buttonLabelText, for: .normal)
        button.backgroundColor = Constant.buttonBackground
        button.layer.cornerRadius = Constant.cornerRadius
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constant.heightAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: Constant.sideAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -Constant.sideAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                           constant: -Constant.bottomAnchor),
        ])
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
    }
    
    private func textField(with placeholder: String?) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = Constant.cornerRadius
        textField.layer.borderColor = UIColor.gray.cgColor
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor
            .constraint(equalToConstant: Constant.heightAnchor).isActive = true
        
        // Fixes wierd behaviour with constraints
        textField.autocorrectionType = .no

        return textField
    }
    
    // MARK: - Actions
    
    @objc private func signInButtonPressed() {
        if let login = loginTextField.text,
            let password = passswordTextField.text,
            let user = User(login: login, password: password) {
            signIn(with: user)
        } else {
            showAlert()
        }
    }
    
    // MARK: - Private Functions
    
    private func signIn(with user: User) {
        navigationController?.pushViewController(ViewController(user: user),
                                                 animated: false)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: Constant.alertTitle,
                                      message: Constant.alertMessage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: - Constants
    
    private enum Constant {
        static let sideAnchor = CGFloat(20)
        static let bottomAnchor = CGFloat(20)
        static let heightAnchor = CGFloat(42)
        static let cornerRadius = CGFloat(10)
        
        static let buttonLabelText = "Go!"
        static let buttonBackground = UIColor(red: 27/255, green: 138/255,
                                              blue: 107/255, alpha: 1)
        
        static let textFieldsSpacing = CGFloat(10)
        
        static let loginPlaceholder = "Login"
        static let passwordPlaceholder = "Password"
        
        static let alertTitle = "Wrong login or password"
        static let alertMessage = "Login and password should be longer than " +                                             "\(User.minPasswordAndLoginLength) letters"
    }
}
