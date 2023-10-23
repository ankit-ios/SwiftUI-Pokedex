//
//  FilterView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct FilterView: View {
    @Binding var isFilterSheetPresented: Bool
    @State private var selectedFilter = "None"
    
    let data: [AccordianModel] = [
        .init(title: "Type", items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8"]),
        .init(title: "Gender", items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 42", "Item 53", "Item 64", "Item 72"]),
        .init(title: "Stats", items: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 42", "Item 53", "Item 64", "Item 72"])
    ]
    
    @State private var isTypeExpanded = false
    @State private var isGenderExpanded = false
    @State private var isStatsExpanded = false
    
    @State var typeCheckedItems: [String: Bool] = [:]
    @State var genderCheckedItems: [String: Bool] = [:]
    @State var statsCheckedItems: [String: Bool] = [:]
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ScrollView {
                        AccordionView(model: data[0], isExpanded: $isTypeExpanded, checkedItems: $typeCheckedItems)
                        AccordionView(model: data[1], isExpanded: $isGenderExpanded, checkedItems: $genderCheckedItems)
                        AccordionView(model: data[2], isExpanded: $isStatsExpanded, checkedItems: $statsCheckedItems)
                        Spacer()
                        
                    }
                    .padding()
                    
                    HStack {
                        Button("Reset") {
                            
                        }
                        .font(.title)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .frame(width: geometry.size.width * 0.4)
                        .background(.white)
                        .foregroundColor(.blue)
                        .cornerRadius(12)

                        
                        Spacer()
                        Button("Apply") {
                            
                        }
                        .font(.title)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .frame(width: geometry.size.width * 0.4)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: -10)
                }
            }
            .navigationBarTitle("Filters")
            .navigationBarItems(
                trailing: Button("Cancel") {
                    isFilterSheetPresented = false
                }
            )
        }
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(isFilterSheetPresented: .constant(false))
    }
}
