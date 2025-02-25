//
//  Person.swift
//  OneStar
//
//  Created by Luana Bueno on 11/02/25.
//

import Foundation
import UIKit

let currentUser = Person(id: "0", profileName: "Luana Bueno", profilePicture: UIImage(named: "memoji1"), receivedPhoto: false)


class Person{
    var id: String
    var profileName: String
    var profilePicture: UIImage?
    var receivedPhotos: [UIImage]?
    var friends: [Person] = []
    var receivedPhoto: Bool = false
    
    init(id: String, profileName: String, profilePicture: UIImage? = nil, receivedPhotos: [UIImage]? = nil, friends: [Person]? = nil, receivedPhoto: Bool) {
        self.id = id
        self.profileName = profileName
        self.profilePicture = profilePicture
        self.receivedPhotos = receivedPhotos
        self.friends = friends ?? []
        self.receivedPhoto = receivedPhoto
    }
    
    func add(friend: Person) {
            friends.append(friend)
            print(friend.profileName)
            NotificationCenter.default.post(name: NSNotification.Name("FriendsUpdated"), object: nil)
        }
}

extension Person {
    static func mockFriends() -> [Person] {
        
        let friends = [
            Person(id: "1", profileName: "Alice Johnson", profilePicture: UIImage(named: "memoji1"), receivedPhoto: true ),
            Person(id: "2", profileName: "Barbie Smith", profilePicture: UIImage(named: "memoji2"), receivedPhoto: true ),
            Person(id: "3", profileName: "Charlie Davis", profilePicture: UIImage(named: "memoji3"), receivedPhoto: false),
            Person(id: "4", profileName: "Diana White", profilePicture: UIImage(named: "memoji4"), receivedPhoto: false),
            Person(id: "5", profileName: "Dilan Brown", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false)
        ]
        
        for friend in friends{
            currentUser.friends.append(friend)
        }
        
        return friends
    }
}

extension Person {
    static func mockPeople() -> [Person] {
        let allPeople =  [
            Person(id: "10", profileName: "Julie King", profilePicture: UIImage(named: "memoji1"), receivedPhoto: false),
            Person(id: "12", profileName: "Sophia Bingham", profilePicture: UIImage(named: "memoji2"), receivedPhoto: false),
            Person(id: "13", profileName: "Charlie Davis", profilePicture: UIImage(named: "memoji3"), receivedPhoto: false),
            Person(id: "14", profileName: "William Harris", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false),
            Person(id: "15", profileName: "Sofia Parker", profilePicture: UIImage(named: "memoji4"), receivedPhoto: false),
            Person(id: "16", profileName: "Lucas Oliveira", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false),
            Person(id: "17", profileName: "Emma Wilson", profilePicture: UIImage(named: "memoji2"), receivedPhoto: false),
            Person(id: "18", profileName: "Noah Martinez", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false),
            Person(id: "19", profileName: "Olivia Taylor", profilePicture: UIImage(named: "memoji4"), receivedPhoto: false),
            Person(id: "20", profileName: "Ethan Johnson", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false),
            Person(id: "21", profileName: "Mia Rodriguez", profilePicture: UIImage(named: "memoji1"), receivedPhoto: false),
            Person(id: "22", profileName: "Benjamin Scott", profilePicture: UIImage(named: "memoji5"), receivedPhoto: false),
            Person(id: "23", profileName: "Ava Cooper", profilePicture: UIImage(named: "memoji3"), receivedPhoto: false)
        ]
        let friendIDs = Set(currentUser.friends.map { $0.id })
        
        let filteredPeople = allPeople.filter { !friendIDs.contains($0.id) } 
        return filteredPeople
        
    }
}

