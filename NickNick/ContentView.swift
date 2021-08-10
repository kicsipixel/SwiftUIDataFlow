//
//  Only for understanding the basic, but in production, it won't really work,
//  because edge cases and errors are not handled
//
//  Naming of the class is not really proper.
//  To make it easier to understand written to code in the same file.
//
//  Nick @Observed @Observabel @Published and so on...
//
//  Created by Szabolcs Tóth on 2021. 08. 09..
//

import SwiftUI

//MARK: 1. Step
// MODEL
struct Person: Codable {
    var results: [Result]
    
    struct Result: Codable, Hashable {
        let gender: Gender
        let name: Name
        
        enum Gender: String, Codable {
            case female
            case male
        }
        
        struct Name: Codable, Hashable {
            let title: String
            let first, last: String
        }
    }
}

//MARK: 2. Step
// NETWORK SERVICE
struct NetworkService {
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

//MARK: 3. Step
// Observable CLASS with Published MODEL
class ContentViewModel: ObservableObject {
    
    @Published var people: [Person.Result] = []
    
    func fetchDataFromAPI() {
        NetworkService.fetchUsers { fetchedPeople in
            DispatchQueue.main.async {
                self.people = fetchedPeople
            }
        }
    }
}

//MARK: 4. Step
// VIEW
struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.people, id:\.self) { person in
                HStack {
                    Image(systemName: person.gender.rawValue == "male" ? "person.crop.circle" : "person.crop.circle.fill")
                        .font(.title2)
                    Text("\(person.name.first)")
                }
            }
        }
        .onAppear {
            self.viewModel.fetchDataFromAPI()
        }
    }
}

//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: Some Advanced stuff...

// Enhancged RowView
struct ListRowView: View {
    
    let person: Person.Result
    
    var body: some View {
        HStack {
            person.content
                .font(.title2)
            Text("\(person.name.title) \(person.name.last),")
                .bold()
            Text("\(person.name.first)")
        }
    }
}

// In real life no one would type: "peron.name.title"...

struct PersonViewModel: Hashable {
    let person: Person.Result
    
    var personName: Person.Result.Name {
        return person.name
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

class PeopleViewModel: ObservableObject {
    
    @Published var people: [PersonViewModel] = []
    
    func fetchDataFromAPI() {
        NetworkService.fetchUsers { fetchPeople in
            DispatchQueue.main.async {
                self.people = fetchPeople.map{ PersonViewModel(person: $0) }
            }
        }
    }
}

struct EContentView: View {
    
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.people, id:\.self) { person in
                //  ListRowView(person: person.person)
                Text("\(person.fullName)")
            }
        }
        .onAppear {
            self.viewModel.fetchDataFromAPI()
        }
        .navigationTitle("People")
    }
}

extension Person.Result {
    
    @ViewBuilder
    var content: some View {
        switch gender {
        case .male:
            Image(systemName: "person.crop.circle")
        case .female:
            Image(systemName: "person.crop.circle.fill")
        }
    }
}
