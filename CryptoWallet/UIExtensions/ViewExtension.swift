//
//  ViewExtension.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

extension UIView {
    func setUpStyle() {
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    func setUpBorder(borderColor: UIColor) {
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
