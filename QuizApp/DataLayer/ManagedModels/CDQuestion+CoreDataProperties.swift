//
//  CDQuestion+CoreDataProperties.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var question: String?
    @NSManaged public var quiz: CDQuiz?

}

extension CDQuestion : Identifiable {

}
