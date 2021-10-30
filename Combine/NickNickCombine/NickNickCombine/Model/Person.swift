//
//  Person.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Foundation

struct Person: Codable {
    var results: [Result]
    
    struct Result: Codable, Hashable {
        var gender: String
        var name: Name
        
        struct Name: Codable, Hashable {
            var title: String
            var firstName: String
            var lastName: String
            
            enum CodingKeys: String, CodingKey {
                case title
                case firstName = "first"
                case lastName = "last"
            }
        }
    }
}

