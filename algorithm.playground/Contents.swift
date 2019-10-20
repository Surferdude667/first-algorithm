import Foundation

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


func orderResult() {
    let sortedResult = results.sorted(by: {$0.rank > $1.rank})
    let result = sortedResult[0]
    
    print("\(result.compared.keys) and \(result.compared.values) have \(result.rank) different interrests! They are: \(result.differentInterests)")
    //print("The ones with most different interests are: \(result.compared.keys) & \(result.compared.values) with \(result.rank) different. ")
        
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


// Compare the interrests
func compareInterest(personObjects: [Person]) {
    
    //Loop all the persons
    for i in 1..<persons.count {
         
        let mainPerson = personObjects[0]
        let secondaryPerson = personObjects[i]
        
        var mainPersonInterests = Set<String>()
        var secondaryPersonInterests = Set<String>()
        
        //Add the interrests of MainPerson to a Set
        for elements in mainPerson.interests.keys {
            mainPersonInterests.insert(elements)
        }
        
        //Add the interrests of SecondaryPerson to a Set
        for elements in secondaryPerson.interests.keys {
            secondaryPersonInterests.insert(elements)
        }
        
        //Find the difference of the two persons.
        let difference = mainPersonInterests.symmetricDifference(secondaryPersonInterests)
        
        
        //Add the result to an array of "Results" objects.
        results.append(Results(compared: [mainPerson.name: secondaryPerson.name], rank: difference.count, differentInterests: difference, id1: mainPerson.id, id2: secondaryPerson.id))
        
    }
    
    //Call order function
    orderResult()
}

compareInterest(personObjects: persons)
