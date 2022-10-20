//
//  CoinsListVC.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

final class CoinsListVC: UIViewController {
    
    var presenter: CoinsListPresenterProtocol?
    
    // MARK: - UI Properties
    let coinsTable: UITableView = {
        let table = UITableView()
        table.setUpStyle()
        return table
    }()
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        return alert
    }()
    let refreshControl = UIRefreshControl()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private let sortSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "По возрастанию", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "По убыванию", at: 1, animated: true)
        return segmentedControl
    }()
    

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinsTable.register(CoinCell.self, forCellReuseIdentifier: "CoinDefault")
        coinsTable.dataSource = self
        coinsTable.delegate = self
        
        setUpUI()
        setUpNavigationBar()
        setUpConstraints()
        
        activityIndicator.startAnimating()
        presenter?.getCoins()
    }
    
    // MARK: - Set Up UI
    private func setUpUI() {
        view.backgroundColor = Colors.background
        title = "Coins"
                
        coinsTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        view.addSubview(sortSegmentedControl)
        view.addSubview(coinsTable)
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Sep Up NavigationBar
    private func setUpNavigationBar() {
        let logOutBarButtonItem: UIBarButtonItem = UIBarButtonItem(
            image: Images.logOut,
            style: .plain,
            target: self,
            action: #selector(logOut))
        logOutBarButtonItem.tintColor = Colors.text
                
        navigationItem.rightBarButtonItems = [logOutBarButtonItem]
                        
        sortSegmentedControl.addTarget(self, action: #selector(sort), for: .valueChanged)
    }
    
    // MARK: - Set Up Constraints
    private func setUpConstraints() {
        
        sortSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sortSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -Constants.padding),
            sortSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.padding),
            sortSegmentedControl.heightAnchor.constraint(equalToConstant: Constants.segmentedControlHeight)
        ])
        
        coinsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coinsTable.topAnchor.constraint(equalTo: sortSegmentedControl.bottomAnchor,
                                            constant: Constants.padding),
            coinsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coinsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coinsTable.trailingAnchor.constraint(equalTo: view
                .safeAreaLayoutGuide.trailingAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: activityIndicator.widthAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: activityIndicator.bounds.width)
        ])
    }
    
    @objc private func logOut() {
        presenter?.logOut()
    }
    
    @objc private func refreshData() {
        refreshControl.beginRefreshing()
        presenter?.getCoins()
    }
    
    @objc private func sort(sender: UISegmentedControl) {
        presenter?.sortCoins(isAccending: sender.selectedSegmentIndex == 0)
        coinsTable.reloadData()
    }
}
