//
//  DrugView.swift
//  ITU
//
//  Created by Nikita Moiseev on 04.11.2023.
//

import SwiftUI

struct DrugView: View {
    @State var scrollOffset: CGPoint = .zero
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let inSectionGap: CGFloat = 8
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text("Stock")
                            .font(.callout)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(.gray.opacity(0.4))
                    .foregroundStyle(Color.black.opacity(0.5))
                    
                    HStack (spacing: inSectionGap) {
                        VStack (spacing: 2) {
                            Text("On hand")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("22")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        VStack (spacing: 2) {
                            Text("Expiry date")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("05/2025")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("General")
                            .font(.callout)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(.gray.opacity(0.4))
                    .foregroundStyle(Color.black.opacity(0.5))
                    
                    VStack (spacing: inSectionGap) {
                        HStack (spacing: inSectionGap) {
                            VStack (spacing: 2) {
                                Text("Strength")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("500MG")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            VStack (spacing: 2) {
                                Text("Form")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Tableta")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        HStack (spacing: inSectionGap) {
                            VStack (spacing: 2) {
                                Text("Package")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("24")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            VStack (spacing: 2) {
                                Text("Route")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Perorální podání")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        HStack (spacing: inSectionGap) {
                            VStack (spacing: 2) {
                                Text("Dosage")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Blistr")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Spacer()
                        }
                        
                        
                        VStack (spacing: 2) {
                            Text("Complement")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("500MG TBL NOB 10 II")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("Legalization")
                            .font(.callout)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(.gray.opacity(0.4))
                    .foregroundStyle(Color.black.opacity(0.5))
                    
                    VStack (spacing: inSectionGap) {
                        VStack (spacing: 2) {
                            Text("Organization")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Aurovitas, spol. s r.o., Praha")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        VStack (spacing: 2) {
                            Text("Organization country")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("ČESKÁ REPUBLIKA")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("PARACETAMOL AUROVITAS")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationView {
        DrugView()
    }
}
