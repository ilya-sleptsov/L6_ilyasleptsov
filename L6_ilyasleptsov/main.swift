//
//  main.swift
//  L6_ilyasleptsov
//
//  Created by Илья Слепцов on 22.03.2021.
//

import Foundation

// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//
// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//
// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.


enum Gender: String {
    case male = "мужской"
    case female = "женский"
}

class Profile {
    let gender: Gender
    let name: String
    let age: Int
    
    init(gender: Gender, name: String, age: Int) {
        self.gender = gender
        self.name = name
        self.age = age
    }
}

extension Profile {
    var toText: String {
        """
        Пол: \(gender.rawValue). Имя: \(name). Возраст: \(age)
        """
    }
}

struct Queue<T> {
    private var elements: [T] = []
    
    func filter(predicate: (T) -> Bool) -> [T] {
        var tempArray: [T] = []
        for element in elements {
            if predicate(element) {
                tempArray.append(element)
            }
        }
        return tempArray
    }
    
    mutating func push (_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
    }
}

extension Queue {
    
    subscript(index: Int) -> T? {
        guard index >= 0 && index < elements.count else {
            return nil
        }
        return elements[index]
    }
}

var profiles = Queue<Profile>()

profiles.push(Profile(gender: .male, name: "Joel", age: 40))
profiles.push(Profile(gender: .female, name: "Elly", age: 14))
profiles.push(Profile(gender: .female, name: "Lara", age: 32))
profiles.push(Profile(gender: .male, name: "Nathan", age: 35))
profiles.push(Profile(gender: .male, name: "Steve", age: 16))

var filterProfiles = profiles.filter() { element in element.age > 18 }
filterProfiles.forEach { print($0.toText) }

