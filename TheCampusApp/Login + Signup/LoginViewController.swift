//
//  SignupViewController.swift
//  TheCampusApp
//
//  Created by Yogesh Kumar on 22/09/19.
//  Copyright © 2019 Harsh Motwani. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
    // MARK:- Constants
    let inputPadding: CGFloat = 20
    let inputHeight: CGFloat = 40
    var stackHeight: CGFloat = 0
    var inputWidth: CGFloat = 0
    var topPadding: CGFloat = 0
    let db = Firestore.firestore()
    
    // MARK:- UI Elements
    
    let header : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Log In"
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = textFieldBackgroundColor
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 18)
        textField.tag = 1
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(checkValidInput), for: .editingChanged)
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.backgroundColor = textFieldBackgroundColor
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 18)
        textField.tag = 2
        textField.addTarget(self, action: #selector(checkValidInput), for: .editingChanged)
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = blueColorFaint
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    let dontHaveAccountButton : UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have an account  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.7)])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium), NSAttributedString.Key.foregroundColor : blueColorDark]))
        button.setAttributedTitle(attributedText, for: .normal)
        return button;
    }()
    
    // MARK:- Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Constants
        stackHeight = inputHeight * 3 + inputPadding * 2
        inputWidth = view.frame.width * 0.8
        topPadding = view.frame.height * 0.4
        
        // Setup Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Handle Keyboard Events
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // UI
        setupUI()
    }
    
    // MARK:- Setup UI Methods
    func setupUI(){
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        setupHeader()
        setupStack()
        setupFooter()
    }
    
    func setupHeader(){
        let height : CGFloat = view.frame.height * 0.10;
        let topPadding: CGFloat = view.frame.height * 0.10;
        let sidePadding : CGFloat = 20
        
        view.addSubview(header)
        
        if #available(iOS 11.0, *) {
            let layoutGuide = view.safeAreaLayoutGuide
            header.anchor(top: layoutGuide.topAnchor, left: layoutGuide.leadingAnchor, right: layoutGuide.trailingAnchor, paddingTop: topPadding, paddingLeft: sidePadding, paddingRight: sidePadding, height: height)
        } else {
            header.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: topPadding, paddingLeft: sidePadding, paddingRight: sidePadding, height: height)
        }
        
    }
    
    func setupStack(){
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = inputPadding
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, paddingTop: topPadding, height: stackHeight, width: inputWidth)
        stack.centerX(view.centerXAnchor)
    }
    
    func setupFooter(){
        view.addSubview(dontHaveAccountButton)
        if #available(iOS 11.0, *) {
            let layoutGuide = view.safeAreaLayoutGuide
            dontHaveAccountButton.anchor(bottom: layoutGuide.bottomAnchor, left: layoutGuide.leadingAnchor, right: layoutGuide.trailingAnchor, paddingBottom: 5, paddingLeft: 10, paddingRight: 10, height: 50)
        } else {
            dontHaveAccountButton.anchor(bottom: view.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingBottom: 5, paddingLeft: 10, paddingRight: 10, height: 50)
        }
        dontHaveAccountButton.addTarget(self, action: #selector(changeToSignUpController), for: .touchUpInside)
    }
    
    
    // MARK:- Triggering Methods
    @objc func changeToSignUpController(){
        print("Sign Up")
        let signUpVC = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleLogin(){
        view.endEditing(true)
        guard let email = emailTextField.text     else {return}
        guard let password = passwordTextField.text     else {return}
        print("Trying To Log In")
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error{
                // This occurs when username or password is wrong
                // TODO:- Add UI to alert user -- Done
                
                let alertController = UIAlertController(title: "Invalid Username/Password", message: "Click 'Sign Up' to create a new account.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (_) in
                    self.emailTextField.text = "";
                    self.passwordTextField.text = "";
                }))
                
                alertController.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { (_) in
                    self.emailTextField.text = "";
                    self.passwordTextField.text = "";
                    self.changeToSignUpController()
                }))
                
                self.present(alertController, animated: true, completion: nil)
                
                print("Login ERROR #1 : \n\n", error)
                return;
            }

            guard let user = user?.user else{
                print("Login Error #2 : \n\n")
                return;
            }
            
            UserData.shared.setData(user)
            
            // Go to Main Tab Bar Controller
            DispatchQueue.main.async {
                if let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController{
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    // This is triggered when Keyboards shows
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
            header.alpha = 0
        }
    }
    
    // This is triggered when keyboards dismisses
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            header.alpha = 1
        }
    }
    
    // This functions check if input text field in valid
    @objc func checkValidInput(){
        let isValidEmail = emailTextField.text?.count ?? 0 > 0
        let passwordLength = passwordTextField.text?.count ?? 0
        let isValidPassword = (passwordLength >= 6) && (passwordLength <= 16)
        if isValidEmail && isValidPassword{
            loginButton.backgroundColor = blueColorDark
            loginButton.isEnabled = true
        }
        else{
            loginButton.backgroundColor = blueColorFaint
            loginButton.isEnabled = false
        }
    }
}

// MARK:- Extension #1
extension LoginViewController : UITextFieldDelegate{
    
    // Move to next Text Field on pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard and perform signup
            textField.resignFirstResponder()
            handleLogin()
        }
        return false
    }
}
