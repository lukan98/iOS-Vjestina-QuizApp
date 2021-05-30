//
//  CDQuestion+CoreDataProperties.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var answers: [String]
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var identifier: Int32
    @NSManaged public var question: String
    @NSManaged public var quiz: CDQuiz

}

extension CDQuestion : Identifiable {

}
