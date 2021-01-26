//
//  StringExtension.swift
//  AppTemplate
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: LanaguageManager.shared.bundle, value: "", comment: "")
    }

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from:self)
    }
}
