struct Person {
    var name: String
    var hometown: String
    var age: Int
    var interests: [String: String] = [:]
    var id: Int
}

struct Results {
    var compared: [String: String] = [:]
    var rank: Int
    var differentInterests = Set<String>()
    var id1: Int
    var id2: Int
}

var results = [Results]()

var persons = [Person(name: "Jack Sparrow", hometown: "Caribbean", age: 42, interests: ["Rum": "An alcoholic drink", "Guns": "A weapon"], id: 0),
               Person(name: "Bjørn Lau Jørgensen", hometown: "Aalborg", age: 25, interests: ["Kitesurfing": "A sport using a kite", "Tech": "Technoligy", "Apple": "Computer"], id: 1),
               Person(name: "Steve Jobs", hometown: "Silicon Vally", age: 52, interests: ["Tech": "Tehcnoligy", "Mercedes": "A car", "Apple": "Computer", "Kitesurfing": "A sport using a kite"], id: 2),
               Person(name: "Bruce Dickinson", hometown: "London", age: 55, interests: ["Music" : "Songs etc.", "Tech":"Tehcnoligy", "Football":"A stupid game"], id: 3),
               Person(name: "Petra Göransson", hometown: "Kungsäter", age: 22, interests: ["Fitness":"Going to the gym", "Music":"Songs etc.", "Tech":"Technoligy"], id: 4),
               Person(name: "Jan Jørgensen", hometown: "Gjøl", age: 57, interests: ["Kitesrufing" : "A sport using a kite", "Guns":"A weapon"], id: 5)]

//  Takes the 'results' array and sorts it based on the 'rank' property in the 'Results' objects.
//  Then prints the result and empties 'result' array. It also removes the two winning persons from the 'persons' array.
//  At last calls the 'compareInterest()' if there is still persons to compare.
func orderResult() {
    let sortedResult = results.sorted(by: {$0.rank > $1.rank})
    let result = sortedResult[0]
    
    print("\(result.compared.keys) and \(result.compared.values) have \(result.rank) different interrests! They are: \(result.differentInterests)")
        
    if let index = persons.firstIndex(where: { $0.id == sortedResult[0].id1 }) {
        persons.remove(at: index)
    }
    
    if let index = persons.firstIndex(where: { $0.id == sortedResult[0].id2 }) {
        persons.remove(at: index)
    }
    
    results.removeAll()
    
    if persons.isEmpty {
        print("Everyone is matched!")
    } else {
        compareInterest(personObjects: persons)
    }
}


//  Compare the interests of the persons provided to the function.
//  The function will add the result to the 'results' array of 'Result' objects.
func compareInterest(personObjects: [Person]) {
    
    //  Loop through all the persons except the first person in the array to
    //  compare every person to the first person in array.
    for i in 1..<persons.count {
         
        let mainPerson = personObjects[0]
        let secondaryPerson = personObjects[i]
        
        var mainPersonInterests = Set<String>()
        var secondaryPersonInterests = Set<String>()
        
        for elements in mainPerson.interests.keys {
            mainPersonInterests.insert(elements)
        }
        
        for elements in secondaryPerson.interests.keys {
            secondaryPersonInterests.insert(elements)
        }
        
        let difference = mainPersonInterests.symmetricDifference(secondaryPersonInterests)
        
        results.append(Results(compared: [mainPerson.name: secondaryPerson.name], rank: difference.count, differentInterests: difference, id1: mainPerson.id, id2: secondaryPerson.id))
        
    }
    
    orderResult()
    
}

compareInterest(personObjects: persons)
