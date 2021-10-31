//
//  PersonViewModel.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Foundation
import SwiftUI

struct PersonViewModel {
    
    let person: Person.Result
    
    var id: UUID {
        return person.id
    }
    
    var gender: Person.Result.Gender {
        return person.gender
    }
    
    var fullName: String {
        return ("\(person.name.firstName) \(person.name.lastName)")
    }
}

extension PersonViewModel {
    
    @ViewBuilder
    var genderImage: some View {
        switch gender {
        case .female:
            Image(systemName: "person.crop.circle")
                .foregroundColor(.pink)
        case .male:
            Image(systemName: "person.crop.circle")
        }
    }
}
