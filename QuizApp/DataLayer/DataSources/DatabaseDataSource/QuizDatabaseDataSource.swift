//
//  QuizDatabaseDataSource.swift
//  QuizApp
//
//  Created by Luka Namačinski on 28.05.2021..
//

import Foundation
import CoreData

struct QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {
    
    private let coreDataContext: NSManagedObjectContext

    init(coreDataContext: NSManagedObjectContext) {
        self.coreDataContext = coreDataContext
    }

}
