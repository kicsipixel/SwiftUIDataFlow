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
    @Published var errorMessage: String? = nil
    
    var cancaellable: AnyCancellable?
    
    func getPeopleByNetworkService() {
        cancaellable = networkService.fetchPeople().sink(receiveCompletion: { [unowned self] err in
            switch err {
            case .finished:
                // Do nothing or just indicate to users that everything done properly
                print("Done...")
            case .failure(let err):
                self.errorMessage = err.localizedDescription
            }
        }, receiveValue: { result in
            self.people = result.results.map { PersonViewModel(person: $0) }
        })
    }
    
}
