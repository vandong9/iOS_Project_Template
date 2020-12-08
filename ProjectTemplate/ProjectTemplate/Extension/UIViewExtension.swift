//
//  UIViewExtension.swift
//  GoExam
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

extension UIView {
    class func instanceFromNib() -> UIView? {
        guard let _ = Bundle.main.path(forResource: String(describing: self), ofType: "nib") else { return nil }
        let array = UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)
        return array.first as? UIView
    }
    
    func borderCircle(color: UIColor, width: CGFloat) {
        layer.cornerRadius = bounds.size.height / 2
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.masksToBounds = true
    }
}

