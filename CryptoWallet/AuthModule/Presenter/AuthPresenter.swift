//
//  AuthPresenter.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import Foundation

protocol AuthViewProtocol: AnyObject { }

protocol AuthPresenterProtocol {
    var view: AuthViewProtocol? { get }
    init(view: AuthViewProtocol, router: MainRouterProtocol)
    func checkLoginInfo(login: String, password: String) -> Bool
    func saveAuthInfo(login: String, password: String)
    func checkAuthentication()
    func showCoinsVC()
}

final class AuthPresenter: AuthPresenterProtocol {
    
    private(set) weak var view: AuthViewProtocol?
    private var router: MainRouterProtocol
    
    init(view: AuthViewProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func checkLoginInfo(login: String, password: String) -> Bool {
        return (login == "User" && password == "1111")
    }
    
    func saveAuthInfo(login: String, password: String) {
        UserDefaults.standard.setValue(login, forKey: "Login")
        UserDefaults.standard.setValue(password, forKey: "Password")
    }
    
    func checkAuthentication() {
        let defaults = UserDefaults.standard
        
        if let login = defaults.object(forKey: "Login") as? String,
           let password = defaults.object(forKey: "Password") as? String,
           checkLoginInfo(login: login, password: password) {
            showCoinsVC()
        }
    }
    
    func showCoinsVC() {
        router.showCoinsVC()
    }
}
