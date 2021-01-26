//
//  LoadingOverlayView.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

class LoadingOverlayView: UIView {
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    var animationIconSize: CGFloat = 240
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        indicator.frame = CGRect(origin: center, size: CGSize(width: animationIconSize, height: animationIconSize))
        addSubview(indicator)
        indicator.color = .gray
        indicator.center = center
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
