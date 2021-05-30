//
//  Question+CD.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//
import CoreData

extension Question {
    
    init(with entity: CDQuestion) {
        self.id = Int(entity.identifier)
        self.question = entity.question
        self.answers = (entity.answers).map({$0})
        self.correctAnswer = Int(entity.correctAnswer)
    }
    
    func populate(_ entity: CDQuestion) {
        entity.identifier = Int32(self.id)
        entity.question = self.question
        entity.answers = NSArray(array: (self.answers).map({$0})) as! Array<String>
        entity.correctAnswer = Int32(self.correctAnswer)
    }
    
}
