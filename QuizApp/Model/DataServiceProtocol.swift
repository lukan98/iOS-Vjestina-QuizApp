protocol DataServiceProtocol {

    func login(email: String, password: String) -> LoginStatus

    func fetchQuizes() -> [Quiz]
    
    func getNoOfQuizCategories() -> (Int)
    
    func getRandomFunFactWord() -> (String)
    
    func getLeaderboard(forQuizID id: Int) -> [LeaderboardResult]

}
