struct Question: Codable {

    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int

}
