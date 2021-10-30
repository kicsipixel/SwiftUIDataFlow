//
//  ContentView.swift
//  NickNickCombine
//
//  Created by Szabolcs Tóth on 2021. 10. 30..
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var peopleViewModel = PeopleViewModel()
    
    var body: some View {
        NavigationView {
            switch peopleViewModel.errorMessage {
            case nil:
                List(peopleViewModel.people, id:\.self) { person in
                    Text(person.fullName)
                }
                .navigationTitle("People")
                
            default:
                Text("\(peopleViewModel.errorMessage!)")
            }
        }
        .onAppear {
            peopleViewModel.getPeopleByNetworkService()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
