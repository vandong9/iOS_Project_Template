//
//  CoreDataService.swift
//  GoExam
//
//  Created by Dong Ha on 11/25/20.
//  Copyright © 2020 Dong. All rights reserved.
//

import CoreData
import UIKit

final class CoreDataService {
    // MARK: - Properties
    static var shared = CoreDataService()

    var context: NSManagedObjectContext!

    // MARK: - LifeCycle
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = appDelegate.persistentContainer.viewContext
        }
    }
}
