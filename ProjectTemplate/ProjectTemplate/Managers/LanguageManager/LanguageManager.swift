//
//  LanguageManager.swift
//  VIBChampion
//
//  Created by ha van dong on 1/15/21.
//

import Foundation

final class LanaguageManager {
    // MARK: - Properties
    private let KEY_USER_SELECTED_LANGUAGE = "KEY_USER_SELECTED_LANGUAGE"
    private let supportedLangauge: [String] = ["vi", "en"]
    private let defaultLanguage = "vi"
    private var currentLanguage = "vi"
    private(set) var bundle: Bundle!
    static let shared: LanaguageManager = LanaguageManager()
        
    // MARK: - LifeCycle
    init() {

        // get current language
        if let savedCode = UserDefaults.standard.string(forKey: KEY_USER_SELECTED_LANGUAGE) {
            if supportedLangauge.contains(savedCode) {
                currentLanguage = savedCode
            } else {
                currentLanguage = defaultLanguage
                updateSelectedLanguageCode(currentLanguage)
            }
        }
        
        updateBundle()
    }
    
    // MARK: - Public
    @discardableResult
    func changeLanguage(code: String) -> Error? {
        if !supportedLangauge.contains(code) {
            return NSError(domain:"", code:0, userInfo:["message": "Not support this code"])
        }
        currentLanguage = code
        updateBundle()

        // Notify to
        NotificationCenter.default.post(name: Notification.changeNotification, object: nil)
        return nil
    }
    
    func changeToVietNamese() {
        changeLanguage(code: "vi")
    }
    
    func changeToEnglish() {
        changeLanguage(code: "en")
    }
    
    // MARK: - Private
    private func updateSelectedLanguageCode(_ code: String) {
        UserDefaults.standard.setValue(code, forKeyPath: KEY_USER_SELECTED_LANGUAGE)
    }
    
    private func updateBundle() {
        let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj")!
        bundle = Bundle(path: path)
    }
}
