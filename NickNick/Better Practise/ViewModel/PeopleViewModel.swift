//
//  PeopleViewModel.swift
//  NickNick
//
//  Created by Szabolcs Tóth on 2021. 08. 14..
//

import Foundation

class PeopleViewModel: ObservableObject {
    
    @Published var people: [PersonViewModel] = []
    
    func fetchDataFromAPI() {
        NetworkServiceAPI.fetchUsers { fetchPeople in
            DispatchQueue.main.async {
                self.people = fetchPeople.map{ PersonViewModel(person: $0) }
            }
        }
    }
}
