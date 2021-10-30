//
//  NetworkService.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import Combine
import Foundation

final class NetworkSerivce {
        
    func fetchPeople() -> AnyPublisher<Person, Error> {
       
        guard let url = URL(string: ApiEndPoint().EndPointString) else {
            let error = URLError(.badURL, userInfo: [NSURLErrorKey: "Someting is wrong with the address..."])
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Person.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
