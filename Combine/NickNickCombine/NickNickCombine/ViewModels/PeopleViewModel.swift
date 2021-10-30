//
//  PeopleViewModel.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Combine
import Foundation

final class PeopleViewModel: ObservableObject {
    
    private let networkService = NetworkSerivce()
    
    @Published var people: [PersonViewModel] = []
    
    var cancaellable: AnyCancellable?
    
    func getPeopleByNetworkService() {
        cancaellable = networkService.fetchPeople().sink(receiveCompletion: { err in
            print(err)
            // TODO: Handle error messages here...
        }, receiveValue: { result in
            self.people = result.results.map { PersonViewModel(person: $0) }
        })
    }
    
}
