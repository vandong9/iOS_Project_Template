//
//  DateExtension.swift
//  GoExam
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import Foundation

extension Date {
    var shortDateString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM / dd / yyyy"
        return dateFormater.string(from: self)
    }
}
