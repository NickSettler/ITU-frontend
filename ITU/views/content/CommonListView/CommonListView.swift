//
//  ListView.swift
//  ITU
//
//  Created by Никита Моисеев on 26.10.2023.
//

import SwiftUI

struct CommonListView: View {
    @AppStorage("access_token") var access_token: String?
    
    @StateObject private var viewModel = CommonListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TabButtons(selectedTab: .constant(1))
                
                TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                    Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
                    Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
//                List(viewModel.searchResults, id: \.id) { drug in
//                    HStack (alignment: .top, spacing: 4) {
//                        Image(systemName: "pill")
//                            .font(.headline)
//                        
//                        VStack (alignment: .leading, spacing: 4) {
//                            Text(drug.name)
//                                .font(.headline)
//                            Text(drug.complement)
//                                .font(.subheadline)
//                        }
//                    }
//                }
//                .listStyle(.inset)
//                .refreshable {
//                    //
//                }
//                .toolbar {
//                    ToolbarItemGroup(placement: .topBarTrailing) {
//                        NavigationLink {
//                            ListView()
//                        } label: {
//                            Image(systemName: "plus.circle")
//                        }
//                    }
//                }
//                .tag("Something")
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchQuery)
    }
}

struct TabButtons: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 5) {
                Image(systemName: "square.and.pencil")
                Text("Profile")
                    .font(.caption)
            }
            .onTapGesture {
                selectedTab = 1
            }
            .foregroundColor(selectedTab == 1 ? .blue : .gray)

            Spacer()
            VStack(spacing: 5) {
                Image(systemName: "dollarsign")
                Text("Invest")
                    .font(.caption)
            }
            .onTapGesture {
                selectedTab = 2
            }
            .foregroundColor(selectedTab == 2 ? .blue : .gray)

            Spacer()
            VStack(spacing: 5) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                Text("Results")
                    .font(.caption)
            }
            .onTapGesture {
                selectedTab = 3
            }
            .foregroundColor(selectedTab == 3 ? .blue : .gray)
            Spacer()
        }
        .padding(.vertical)
        .background(
            Rectangle()
                .fill(.quaternary)
        )
    }
}

#Preview {
    CommonListView()
}
