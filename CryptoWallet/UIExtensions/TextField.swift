//
//  TextField.swift
//  CryptoWallet
//
//  Created by Timur Sharafutdinov on 19.10.2022.
//

import UIKit

final class TextField: UITextField {
    private let padding = UIEdgeInsets(top: Constants.texFieldVerticalPadding,
                                       left: Constants.texFieldHorizantalPadding,
                                       bottom: Constants.texFieldVerticalPadding,
                                       right: Constants.texFieldHorizantalPadding)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
