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

//MARK: 1. Step - MODEL
/// This is Person model
/// The JSON response is an array:
/// - gender (male/female)
/// - name
///
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
        NavigationView {
            List {
                ForEach(viewModel.people, id:\.self) { person in
                    HStack {
                        Image(systemName: person.gender.rawValue == "male" ? "person.crop.circle" : "person.crop.circle.fill")
                            .font(.title2)
                        NavigationLink("\(person.name.first)", destination:Text("\(person.name.first) - \(person.gender.rawValue)"))
                    }
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
