//
//  ListRowView.swift
//  NickNick
//
//  Created by Szabolcs Tóth on 2021. 08. 14..
//

import SwiftUI
/// ListRowView to construct each row individually
struct ListRowView: View {
    
    let person: PersonViewModel
    
    var body: some View {
        HStack {
            person.genderImage
                .font(.title2)
            Text("\(person.personTitle) \(person.lastName),")
                .bold()
            Text("\(person.firstName)")
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(person: PersonViewModel(person: Person.Result(gender: .male, name: .init(title: "Mr", first: "Nick", last: "the King"))))
    }
}
