//
//  EContentView.swift
//  NickNick
//
//  Created by Szabolcs Tóth on 2021. 08. 14..
//

import SwiftUI

struct EContentView: View {
    
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.people, id:\.self) { person in
                ListRowView(person: person)
            }
        }
        .onAppear {
            self.viewModel.fetchDataFromAPI()
        }
        .navigationTitle("People")
    }
}

struct EContentView_Previews: PreviewProvider {
    static var previews: some View {
        EContentView()
    }
}
