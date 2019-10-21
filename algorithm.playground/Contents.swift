struct Person {
    var name: String
    var hometown: String
    var age: Int
    var interests: [String: String] = [:]
    var id: Int //  Must be a unique Int.
}

struct Results {
    var compared: [String: String] = [:]
    var rank: Int
    var differentInterests = Set<String>()
    var id1: Int
    var id2: Int
}

var persons = [Person(name: "Jack Sparrow", hometown: "Caribbean", age: 42, interests: ["Rum": "An alcoholic drink", "Guns": "A weapon"], id: 10),
               Person(name: "Bjørn Lau Jørgensen", hometown: "Aalborg", age: 25, interests: ["Kitesurfing": "A sport using a kite", "Tech": "Technoligy", "Apple": "Computer"], id: 11),
               Person(name: "Steve Jobs", hometown: "Silicon Vally", age: 52, interests: ["Tech": "Tehcnoligy", "Mercedes": "A car", "Apple": "Computer", "Kitesurfing": "A sport using a kite"], id: 12),
               Person(name: "Bruce Dickinson", hometown: "London", age: 55, interests: ["Music" : "Songs etc.", "Tech":"Tehcnoligy", "Football":"A stupid game"], id: 13),
               Person(name: "Petra Göransson", hometown: "Kungsäter", age: 22, interests: ["Fitness":"Going to the gym", "Music":"Songs etc.", "Tech":"Technoligy", "Kitesurfing" : "A sport using a kite"], id: 14),
               Person(name: "Jan Jørgensen", hometown: "Gjøl", age: 57, interests: ["Kitesurfing" : "A sport using a kite", "Guns":"A weapon"], id: 15),
               Person(name: "Kasper Pedersen", hometown: "Aalborg", age: 50, interests: ["Kitesurfing" : "A sport using a kite", "Guns":"A weapon"], id: 16)]


//  Accepts an array of Results objects.
//  Shuffels the result array then sorts based on the rank property.
//  Selects the top match and removes the two persons all places they appear in the result array.
func orderResult(resultObjects: [Results]) {
    let shuffeledResult = resultObjects.shuffled()
    var sortedResult = shuffeledResult.sorted(by: {$0.rank > $1.rank})
    
    while sortedResult.isEmpty == false  {
        let topMatch = sortedResult[0]
        
        let updatedResults = sortedResult.filter(){$0.id1 != topMatch.id1 && $0.id1 != topMatch.id2 && $0.id2 != topMatch.id1 && $0.id2 != topMatch.id2}
        sortedResult = updatedResults
        
        print("\nMATCH! Rank: \(topMatch.rank) -> \(topMatch.compared.keys) and \(topMatch.compared.values). The differences is: \(topMatch.differentInterests)")
    }
}

//  Accepts an array of Person objects.
//  Compares all persons interests agains each other.
//  Outputs the result as an array of Results obejcts.
func compareInterest(personObjects: [Person]) -> [Results] {
    var results = [Results]()
        
        for personCount in 0..<persons.count {
            
            for i in personCount..<persons.count {
                
                let mainPerson = personObjects[personCount]
                let secondaryPerson = personObjects[i]
                
                var mainPersonInterests = Set<String>()
                var secondaryPersonInterests = Set<String>()
                
                for elements in mainPerson.interests.keys {
                    mainPersonInterests.insert(elements)
                }
                
                for elements in secondaryPerson.interests.keys {
                    secondaryPersonInterests.insert(elements)
                }
                
                let commons = mainPersonInterests.intersection(secondaryPersonInterests)
                let difference = mainPersonInterests.symmetricDifference(secondaryPersonInterests)
                let combinedRank = difference.count - commons.count
                
                if mainPerson.id != secondaryPerson.id {
                    results.append(Results(compared: [mainPerson.name: secondaryPerson.name], rank: combinedRank, differentInterests: difference, id1: mainPerson.id, id2: secondaryPerson.id))
                    
                    print("Katie just compared: \(mainPerson.name), age: \(mainPerson.age), from: \(mainPerson.hometown) to: -> \(secondaryPerson.name) age: \(secondaryPerson.age), from: \(secondaryPerson.hometown). Result: \(difference.count) different interests.")
                }
            }
        }
    return results
}

orderResult(resultObjects: compareInterest(personObjects: persons))
