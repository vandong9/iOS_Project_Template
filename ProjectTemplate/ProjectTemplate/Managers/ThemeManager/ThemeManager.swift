//
//  ThemeManager.swift
//  ProjectTemplate
//
//  Created by dongha on 19/04/2021.
//

import Foundation

struct ThemeInfo {
    var name: String
    var instance: BaseTheme
}

class ThemeManager {
    static let shared = ThemeManager()
    
    let avaibleThemes: [ThemeInfo] = [ThemeInfo(name: "Orange", instance: OrangeTheme()), ThemeInfo(name: "Blue", instance: BlueTheme())]
    
    private(set) var currentTheme: ThemeInfo
    
    init() {
        currentTheme = avaibleThemes.first!
    }
}
