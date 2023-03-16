//
//  Font.swift
//  TestApp
//
//  Created by Yulia Ignateva on 15.03.2023.
//

import UIKit

extension UIFont {
    static func specialFont(size: CGFloat, style: Style) -> UIFont {
        switch style {
        case .regular: return UIFont(name: "Montserrat-Regular", size: size)!
        case .bold: return UIFont(name: "Montserrat-Bold", size: size)!
        }
    }
}

enum Style {
    case regular
    case bold
}
