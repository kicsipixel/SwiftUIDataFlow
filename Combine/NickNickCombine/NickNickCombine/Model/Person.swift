//
//  Person.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Foundation

struct Person: Codable {
    var results: [Result]
    
    struct Result: Codable, Identifiable {
        var id = UUID()
        var gender: Gender
        var name: Name
        
        enum Gender: String, Codable {
            case female
            case male
        }
        
        enum CodingKeys: String, CodingKey {
            case gender
            case name
        }
        
        struct Name: Codable {
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

