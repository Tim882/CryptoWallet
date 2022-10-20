//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

final class AuthVC: UIViewController {
    
    var presenter: AuthPresenterProtocol?
    
    // MARK: - UI Properties
    private let loginTextField: TextField = {
        let textField = TextField()
        textField.setUpStyle()
        textField.placeholder = "Логин"
        textField.tag = 0
        textField.setUpBorder(borderColor: Colors.middleDarkAppColor)
        return textField
    }()
    private let passwordTextField: TextField = {
        let textField = TextField()
        textField.setUpStyle()
        textField.placeholder = "Пароль"
        textField.tag = 1
        textField.setUpBorder(borderColor: Colors.middleDarkAppColor)
        textField.isSecureTextEntry = true
        return textField
    }()
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setUpStyle()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(Colors.middleDarkAppColor, for: .normal)
        button.backgroundColor = Colors.lightAppColor
        button.setUpBorder(borderColor: Colors.middleDarkAppColor)
        return button
    }()
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setUp(axis: .vertical,
                        distribution: .fill,
                        alignment: .fill,
                        spacing: Constants.spacing)
        return stackView
    }()
    private let alert: UIAlertController = {
        let alert = UIAlertController(title: "Error",
                                      message: "Error description",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        return alert
    }()
    
    // MARK: - ViewCintroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        presenter?.checkAuthentication()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateUIForKeyboard),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateUIForKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateUIForKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    // MARK: - Set Up UI
    private func setUpUI() {
        title = "Auth"
        view.backgroundColor = Colors.background
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        logInButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
                        
        view.addSubview(mainStackView)
    }
    
    // MARK: - Set Up Constraints
    private func setUpConstraints() {
        mainStackView.addArrangedSubview(loginTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(logInButton)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStackView.heightAnchor.constraint(equalTo: loginTextField.heightAnchor,
                                                  multiplier: 3),
            mainStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    // MARK: - Log In
    @objc private func logIn() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let loginReslut = presenter?.checkLoginInfo(login: login, password: password) else {
            return
        }
                
        if loginReslut {
            presenter?.saveAuthInfo(login: login, password: password)
            presenter?.showCoinsVC()
        } else {
            alert.title = "Could not log in"
            alert.message = "Wrong login or password"
            present(alert, animated: true)
        }
    }
    
    // MARK: - Remove Keyboard
    @objc private func removeKeyBoard() {
        view.endEditing(true)
    }
    
    // MARK: - Text Field Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField.tag == 1 {
            logIn()
            return true
        }
        
        return false
    }
    
    @objc private func updateUIForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenAndFrame = keyboardValue.cgRectValue
        let keybordViewAndFrame = view.convert(keyboardScreenAndFrame, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            view.bounds = CGRect(x: 0,
                                 y: 0,
                                 width: view.bounds.width,
                                 height: view.bounds.height)
        } else {
            if mainStackView.frame.maxY > view.bounds.height - keybordViewAndFrame.height {
                view.bounds = CGRect(x: 0,
                                     y: mainStackView.frame.maxY - view.bounds.height + keybordViewAndFrame.height,
                                     width: view.bounds.width,
                                     height: view.bounds.height)
            }
        }
    }
}

