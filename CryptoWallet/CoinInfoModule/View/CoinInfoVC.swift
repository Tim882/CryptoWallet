//
//  CoinInfoVC.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 06.10.2022.
//

import UIKit

final class CoinInfoVC: UIViewController {
    
    var presenter: CoinInfoPresenterProtocol?
    let contentTable = UITableView()
    let refreshControl = UIRefreshControl()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        return alert
    }()
    private var logOutBarButton = UIBarButtonItem()

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTable.dataSource = self
        
        setUpUI()
        setUpConstraints()
        
        activityIndicator.startAnimating()
        presenter?.getCoinInfo()
    }
    
    // MARK: - Set Up UI
    private func setUpUI() {
        title = "Info"
        view.backgroundColor = Colors.background
        
        logOutBarButton = UIBarButtonItem(image: Images.logOut,
                                          style: .plain,
                                          target: self,
                                          action: #selector(logOut))
        navigationItem.rightBarButtonItems = [logOutBarButton]
        
        contentTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        contentTable.allowsSelection = false
        
        view.addSubview(contentTable)
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Set Up Constraints
    private func setUpConstraints() {
        contentTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: activityIndicator.bounds.height)
        ])
    }
    
    @objc func reloadData() {
        refreshControl.beginRefreshing()
        presenter?.getCoinInfo()
    }
    
    @objc private func logOut() {
        presenter?.logOut()
    }
}
