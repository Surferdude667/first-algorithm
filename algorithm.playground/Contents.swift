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

var persons = [Person(name: "Jack Sparrow",
                      hometown: "Caribbean",
                      age: 42,
                      interests: ["Rum": "Rum is a distilled alcoholic drink",
                                  "Black Pearl": "The Black Pearl was originally a merchant ship called Wicked Wench",
                                  "Ships": "A ship is a large watercraft that travels the world's oceans",
                                  "Piloting": "Piloting (on water) or pilotage (in the air) is navigating, using fixed points of reference on the sea or on land"],
                      id: 10),
               Person(name: "Luke Skywalker",
                      hometown: "In a galaxy far far away",
                      age: 19,
                      interests: ["The Force": "The Force is a metaphysical and ubiquitous power",
                                  "Lightsabers": "A typical lightsaber is depicted as a luminescent blade of magnetically contained plasma",
                                  "Droids": "A droid is a robot possessing some degree of artificial intelligence",
                                  "Piloting": "Piloting (on water) or pilotage (in the air) is navigating, using fixed points of reference on the sea or on land"],
                      id: 11),
               Person(name: "Steve Jobs",
                      hometown: "Silicon Valley",
                      age: 56,
                      interests: ["Apple": "Apple Inc. is an American multinational technology company",
                                  "Mercedes-Benz": "German global automobile marque and a division of Daimler AG",
                                  "Innovation": "Innovation is often also viewed as the application of better solutions",
                                  "Bob Dylan": "American singer-songwriter, author, and visual artist",
                                  "Music": "Music is an art form and cultural activity whose medium is sound organized in time.",
                                  "Design": "A design is a plan or specification for the construction of an object or system"],
                      id: 12),
               Person(name: "Bruce Dickinson",
                      hometown: "London",
                      age: 55,
                      interests: ["Music": "Music is an art form and cultural activity whose medium is sound organized in time.",
                                  "Piloting": "Piloting (on water) or pilotage (in the air) is navigating, using fixed points of reference on the sea or on land",
                                  "Rum": "Rum is a distilled alcoholic drink",
                                  "Iron Maiden": "Iron Maiden are an English heavy metal band formed in Leyton, East London"],
                      id: 13),
               Person(name: "Bjørn Lau Jørgensen",
                      hometown: "Aalbrog",
                      age: 25,
                      interests: ["Music": "Music is an art form and cultural activity whose medium is sound organized in time.",
                                  "Iron Maiden": "Iron Maiden are an English heavy metal band formed in Leyton, East London",
                                  "Design": "A design is a plan or specification for the construction of an object or system",
                                  "Kitesurfing" : "Kiteboarding is an action sport combining aspects of wakeboarding, snowboarding, windsurfing, surfing, paragliding, skateboarding and sailing into one extreme sport",
                                  "Skiing": "Skiing is a means of transport using skis to glide on snow."],
                      id: 14),
               Person(name: "Batman",
                      hometown: "Gotham City",
                      age: 32,
                      interests: ["Playboy lifestyle" : "A playboy lifestyle is the lifestyle of a wealthy man with ample time for leisure",
                                  "Piloting": "Piloting (on water) or pilotage (in the air) is navigating, using fixed points of reference on the sea or on land",
                                  "Justice": "Justice, in its broadest context, includes both the attainment of that which is just and the philosophical discussion of that which is just.",
                                  "Skiing": "Skiing is a means of transport using skis to glide on snow."],
                      id: 15),
               Person(name: "Darth Vader",
                      hometown: "Death Star",
                      age: 50,
                      interests: ["Piloting": "Piloting (on water) or pilotage (in the air) is navigating, using fixed points of reference on the sea or on land",
                                  "The Force": "The Force is a metaphysical and ubiquitous power",
                                  "Lightsabers": "A typical lightsaber is depicted as a luminescent blade of magnetically contained plasma",
                                  "Weapons of mass destruction": "A weapon of mass destruction (WMD) is a nuclear, radiological, chemical, biological, or any other weapon that can kill and bring significant harm"],
                      id: 16),
               Person(name: "Katy Perry",
                      hometown: "Los Angeles",
                      age: 34,
                      interests: ["Music": "Music is an art form and cultural activity whose medium is sound organized in time.",
                                  "Dogs": "The dog was the first species to be domesticated",
                                  "Cosmetics": "Cosmetics are substances or products used to enhance or alter the appearance of the face or fragrance and texture of the body.",
                                  "Design": "A design is a plan or specification for the construction of an object or system",
                                  "Rum": "Rum is a distilled alcoholic drink"],
                      id: 17)]


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
