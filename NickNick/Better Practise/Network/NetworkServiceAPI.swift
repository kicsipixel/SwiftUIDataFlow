//
//  NetworkServiceAPI.swift
//  NickNick
//
//  Created by Szabolcs Tóth on 2021. 08. 14..
//

import Foundation

struct NetworkServiceAPI {
    static func fetchUsers(completion: @escaping(([Person.Result]) -> Void)) {
        if let url = URL(string: "https://randomuser.me/api/?nat=us&results=20&inc=gender,name") {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                //FIXME: response and error should be handled
                if let data = data {
                    let person = try? JSONDecoder().decode(Person.self, from: data)
                    // completion with empty array because we are not handling error...
                    completion(person?.results ?? [])
                }
            }.resume()
        }
    }
}
