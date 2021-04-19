//
//  BlueTheme.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import UIKit

class BlueTheme: BaseTheme {
    var font: Font
    
    init(font: Font = BlueTheme.OrangeFont()) {
        self.font = font
    }

    class OrangeFont: Font {
        func regular(_ size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func medium(_ size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func semibold(_ size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func bold(_ size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func italic(_ size: CGFloat) -> UIFont {
            return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
    }


}
