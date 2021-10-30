//
//  PersonViewModel.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Foundation

struct PersonViewModel: Hashable {
    
    let person: Person.Result
    
    var fullName: String {
        return ("\(person.name.firstName) \(person.name.lastName)")
    }
}
