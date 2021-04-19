//
//  BaseTheme.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import UIKit

protocol Image {
    
}

protocol Color {
    
}

protocol Font {
    func regular(_ size: CGFloat) -> UIFont
    func medium(_ size: CGFloat) -> UIFont
    func semibold(_ size: CGFloat) -> UIFont
    func bold(_ size: CGFloat) -> UIFont
    func italic(_ size: CGFloat) -> UIFont
}


protocol BaseTheme: Color, Image {
    var font: Font { get }
    
}
