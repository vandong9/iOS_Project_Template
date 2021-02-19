//
//  AppColor.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

enum AppColor {
    case mainBackGround
    case inputBorderActive
    case inputBorderInactive
    /// MARK: - Text
    case error
    case captionActive
    case captionInActive
    case textActive
    case textInactive
    case title
    
    case blue

    var color: UIColor {
        switch self {
        case .mainBackGround:
            return UIColor(named: "mainBackGround") ??  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .inputBorderActive:
            return UIColor(named: "inputBorderActive") ??  #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
        case .inputBorderInactive:
            return UIColor(named: "inputBorderInactive") ??  #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        case .error:
            return UIColor(named: "error") ?? #colorLiteral(red: 0.968627451, green: 0.1921568627, blue: 0.2392156863, alpha: 1)
        case .captionActive:
            return UIColor(named: "captionActive") ?? #colorLiteral(red: 0, green: 0.4, blue: 0.6980392157, alpha: 1)
        case .captionInActive:
            return UIColor(named: "captionInActive") ?? #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        case .textActive:
            return UIColor(named: "textActive") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .textInactive:
            return UIColor(named: "textInactive") ?? #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)

        case .blue:
            return #colorLiteral(red: 0, green: 0.4, blue: 0.6980392157, alpha: 1)
        case .title:
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}

enum AppRangeColor {
    case mainButton
    
    var colors: [UIColor] {
        switch self {
        case .mainButton:
            return [#colorLiteral(red: 0.9960784314, green: 0.6196078431, blue: 0, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.4156862745, blue: 0, alpha: 1)]
        }
    }
}


extension UIColor {
  static let error: UIColor = UIColor(named: "error")!
}
