//
//  UIButtonTextStylable.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

extension UIButton: TextStylable {
    private struct AssociateObjectKey {
        static var appTextStyle: TextStyle?
    }
    
    var appTextStyle: TextStyle? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociateObjectKey.appTextStyle) as? TextStyle else {
                return nil
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociateObjectKey.appTextStyle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let textColor = newValue?.color {
                self.setTitleColor(textColor, for: .normal)
            }
            if let font = newValue?.font {
                self.titleLabel?.font = font
            }
        }
    }
    
    @IBInspectable var textStyle: String {
        get { return "" }
        set {
            if let type = AppTextStyle.allCases.first(where: { $0.rawValue == newValue }) {
                self.appTextStyle = type.textStyle
            }
        }
    }
}
