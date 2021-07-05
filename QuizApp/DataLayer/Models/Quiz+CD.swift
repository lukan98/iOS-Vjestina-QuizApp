//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//
import CoreData

extension Quiz {
    
    init(with entity: CDQuiz) {
        self.id = Int(entity.identifier)
        self.title = entity.title
        self.description = entity.about
        self.category = QuizCategory.init(rawValue: entity.category)!
        self.level = Int(entity.level)
        self.imageUrl = entity.imageUrl
        self.questions = (entity.questions.allObjects as! [CDQuestion]).map({Question(with: $0)})
    }
    
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(self.id)
        entity.title = self.title
        entity.about = self.description
        entity.category = self.category.rawValue
        entity.level = Int32(self.level)
        entity.imageUrl = self.imageUrl
        entity.questions = NSSet(array: (self.questions).map({
            question in
            let cdQuestion = CDQuestion(context: context)
            question.populate(cdQuestion)
            return cdQuestion
        }))
    }
    
}
