//
//  PersonViewModel.swift
//  NickNick
//
//  Created by Szabolcs Tóth on 2021. 08. 14..
//

import Foundation
import SwiftUI

/// Use your imagination to create whatever you want or need later
struct PersonViewModel: Hashable {
    let person: Person.Result
    
    var personName: Person.Result.Name {
        return person.name
    }
    
    var gender: Person.Result.Gender {
        return person.gender
    }
    
    var personTitle: String {
        return personName.title
    }
    
    var firstName: String {
        return personName.first
    }
    
    var lastName: String {
        return personName.last
    }
    
    var fullName: String {
        return "\(personTitle) \(firstName) \(lastName.uppercased())"
    }
}

extension PersonViewModel {
    
    @ViewBuilder
    var genderImage: some View {
        switch gender {
        case .male:
            Image(systemName: "person.crop.circle")
        case .female:
            Image(systemName: "person.crop.circle.fill")
        }
    }
}
