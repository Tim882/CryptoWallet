//
//  StackViewExtension.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 09.09.2022.
//

import UIKit

extension UIStackView {
    func setUp(axis: NSLayoutConstraint.Axis,
               distribution: Distribution,
               alignment: Alignment,
               spacing: CGFloat) {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
