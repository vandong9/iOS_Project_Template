//
//  TextStyle.swift
//  AppTemplate
//
//  Copyright © 2020 Dong. All rights reserved.
//
import Foundation
import UIKit

struct TextStyle {
    var font: UIFont?
    var color: UIColor?
    var stringAttributes: [NSAttributedString.Key: Any] = [:]
    
    public init(){}
}

extension TextStyle {
    private func with(_ changes: (inout TextStyle) -> ()) -> TextStyle {
        var changedTextStyle = self
        changes(&changedTextStyle)
        return changedTextStyle
    }
    
    func with(font: UIFont) -> TextStyle {
        with { $0.font = font }
    }
    func with(color: UIColor) -> TextStyle {
        with { $0.color = color }
    }
    func with(_ key: NSAttributedString.Key, _ value: Any) -> TextStyle {
        with { $0.stringAttributes[key] = value }
    }
}

enum AppTextStyle: String, CaseIterable {
    case caption1 = "caption1"
    case text1 = "text1"
    
    var textStyle: TextStyle {
        switch self {
        case .caption1:
            return TextStyle().with(font: AppFont.normal(10).font)
        case .text1:
            return TextStyle().with(color: .yellow)
        }
    }
}

