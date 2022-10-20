//
//  CoinCell.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 12.09.2022.
//

import UIKit

final class CoinCell: UITableViewCell {
    
    private let coinNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Constants.verticalStackViewMargins,
                                               left: Constants.horizontalStackViewMargins,
                                               bottom: Constants.verticalStackViewMargins,
                                               right: Constants.horizontalStackViewMargins)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainStackView.addArrangedSubview(coinNameLabel)
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(changeLabel)
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpInfo(name: String, price: String, change: String, isPositiveChange: Bool) {
        coinNameLabel.text = name
        priceLabel.text = price
        let changeAttributedString = NSAttributedString(
            string: change,
            attributes: [NSAttributedString.Key.foregroundColor: isPositiveChange ? UIColor.green : UIColor.red])
        changeLabel.attributedText = changeAttributedString
    }

    func setUpInfo(price: String, change: String, isPositiveChange: Bool) {
        var configuration = defaultContentConfiguration()
        configuration.text = price
        let changeAttributedString = NSAttributedString(
            string: change,
            attributes: [NSAttributedString.Key.foregroundColor: isPositiveChange ? UIColor.green : UIColor.red])
        configuration.secondaryAttributedText = changeAttributedString
        self.contentConfiguration = configuration
    }
}
