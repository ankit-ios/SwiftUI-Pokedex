//
//  SearchBar.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    let searchAction: () -> Void
    
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.black.opacity(0.5) : .black)
            
            TextField("Search by name", text: $searchText)
                .textFieldStyle(.plain)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing)
                .onChange(of: searchText) { newValue in
                    searchText = newValue
                }
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.background)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
        )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), searchAction: {})
    }
}
