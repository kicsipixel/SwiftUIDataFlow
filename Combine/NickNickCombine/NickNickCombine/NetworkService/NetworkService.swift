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
        return URLSession.shared.dataTaskPublisher(for: URL(string: ApiEndPoint().EndPointString)!) // FIXME: check if url is valid
            .map { $0.data }
            .decode(type: Person.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
