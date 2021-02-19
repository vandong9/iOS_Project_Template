//
//  AppFont.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

enum AppFont {
    case regular(_ size: CGFloat = 14)
    case medium(_ size: CGFloat = 14)
    case semibold(_ size: CGFloat = 18)
    case bold(_ size: CGFloat = 18)
    
    var font: UIFont {
        switch self {
        case .regular(let size): return UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium(let size): return UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .semibold(let size): return UIFont(name: "SFProDisplay-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold(let size): return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
