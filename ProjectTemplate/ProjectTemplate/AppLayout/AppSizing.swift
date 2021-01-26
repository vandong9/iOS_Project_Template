//
//  AppSpacing.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//

import UIKit

///
/// Note:
///         - to -> bigger to smaller  // should define from header to detail
///         - between  -> equal
///         - These size should follow the design, design should be consistent the screen size.
///

enum AppSpacing {
    case betweenContent
    case betweenSection
    case headerToContent
    
    var size: CGFloat {
        switch self {
        case .betweenSection:
            return 16
        case .headerToContent:
            return 8
        case .betweenContent:
            return 4
        }
    }
}

enum AppSize {
    case buttonRadius
    
    var size: CGFloat {
        switch self {
        case .buttonRadius:
            return 5
        }
    }
}
