//
//  DrugViewInner.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

struct DrugViewInner: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject var viewModel: DrugViewModel
    
    var drugViewVisible: Binding<Bool>
    
    var size: CGSize
    var safeArea: EdgeInsets
    @State var offsetY: CGFloat = 0
    
    var sectionGap: CGFloat = 32
    var subSectionGap: CGFloat = 12
    var toastGap: CGFloat = 8
    
    init(_ drugViewVisible: Binding<Bool>, size: CGSize, safeArea: EdgeInsets, drug: Binding<Drug>) {
        self.drugViewVisible = drugViewVisible
        self.size = size
        self.safeArea = safeArea
        self._viewModel = StateObject(
            wrappedValue: DrugViewModel(drug: drug)
        )
    }
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                        .zIndex(1000)
                    
                    VStack(spacing: sectionGap) {
                        VStack(alignment: .leading, spacing: subSectionGap) {
                            SectionTitle("Actions")
                                .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    DrugButton(title: "Move", icon: "folder.fill") {
                                        viewModel.isMoveVisible = true
                                    }
                                    DrugButton(title: "Update", icon: "pencil") {
                                        viewModel.isUpdateVisible = true
                                    }
                                    DrugButton(title: "Delete", color: .error, icon: "trash.fill") {
                                        viewModel.deleteDrug()
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: subSectionGap) {
                            SectionTitle("Personal")
                            
                            VStack(spacing: toastGap) {
                                DrugToast(
                                    role: viewModel.expiryDateToastRole,
                                    title: "Expiration date",
                                    text: viewModel.drug.expiration_date.formatted(.dateTime.month(.twoDigits).year())
                                )
                                
                                if let location = viewModel.drug.location {
                                    DrugToast(
                                        role: .success,
                                        title: "Location",
                                        text: location.name
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(alignment: .leading, spacing: subSectionGap) {
                            SectionTitle("General")
                            
                            VStack(spacing: toastGap) {
                                if let strength = viewModel.drug.strength {
                                    DrugToast(
                                        role: .success,
                                        title: "Strength",
                                        text: strength
                                    )
                                }
                                
                                if let form = viewModel.drug.form?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Form",
                                        text: form
                                    )
                                }
                                
                                if let route = viewModel.drug.route?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Route",
                                        text: route
                                    )
                                }
                                
                                if let package = viewModel.drug.package {
                                    DrugToast(
                                        role: .success,
                                        title: "Package",
                                        text: package
                                    )
                                }
                                
                                if let dosage = viewModel.drug.dosage?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Dosage",
                                        text: dosage
                                    )
                                }
                                
                                if let pharm_class = viewModel.drug.pharm_class?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Drug class",
                                        text: pharm_class
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(alignment: .leading, spacing: subSectionGap) {
                            SectionTitle("Sources")
                            
                            VStack(spacing: toastGap) {
                                if let organization = viewModel.drug.organization?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Organization",
                                        text: organization
                                    )
                                }
                                
                                if let organization_country = viewModel.drug.organization_country?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Organization country",
                                        text: organization_country
                                    )
                                }
                                
                                if let actual_organization = viewModel.drug.actual_organization?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Actual organization",
                                        text: actual_organization
                                    )
                                }
                                
                                if let actual_organization_country = viewModel.drug.actual_organization_country?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Actual organization country",
                                        text: actual_organization_country
                                    )
                                }
                                
                                if let concurrent_import = viewModel.drug.concurrent_import {
                                    DrugToast(
                                        role: .success,
                                        title: "Concurrent import",
                                        text: concurrent_import
                                    )
                                }
                                
                                if let concurrent_import_organization = viewModel.drug.concurrent_import_organization?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Concurrent import organization",
                                        text: concurrent_import_organization
                                    )
                                }
                                
                                if let concurrent_import_country = viewModel.drug.concurrent_import_country?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Concurrent import organization country",
                                        text: concurrent_import_country
                                    )
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Registraion")
                                
                                if let registration_status = viewModel.drug.registration_status?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Registration status",
                                        text: registration_status
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.top, 16)
                }
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
                    } onDraggingEnd: { offset, velocity in
                        /// Resetting to Intial State, if not Completely Scrolled
                        let headerHeight = (size.height * 0.3) + safeArea.top
                        let minimumHeaderHeight = 65 + safeArea.top
                        
                        let targetEnd = offset + (velocity * 45)
                        if targetEnd < (headerHeight - minimumHeaderHeight) && targetEnd > 0 {
                            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
                            }
                        }
                        
                        let pillProgress = max(min(offsetY / minimumHeaderHeight, 1), 0)
                        if pillProgress == 1 {
                            viewModel.getDrugInfo()
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .onReceive(viewModel.$isDeletedRequestComplete) {
                if $0 {
                    self.dismiss()
                    self.drugViewVisible.wrappedValue = false
                }
            }
            .sheet(isPresented: $viewModel.isUpdateVisible) {
                DrugAdditionView(drug: $viewModel.drug)
            }
            .sheet(isPresented: $viewModel.isMoveVisible) {
                DrugMoveSheet(drugID: viewModel.drug.id, currentFolder: viewModel.drug.location ?? .empty)
            }
        }
    }
    
    @ViewBuilder
    func SectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.helvetica16)
            .fontWeight(.bold)
            .padding(.horizontal, 6)
            .foregroundStyle(.primary600)
            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        let headerHeight = (size.height * 0.25) + safeArea.top
        let minimumHeaderHeight = 96 + safeArea.top
        /// Converting Offset into Progress
        /// Limiting it to 0 - 1
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        
        return GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.Primary50, .Primary100],
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
                
                VStack(spacing: 0) {
                    Image(systemName: "pill.fill")
                        .foregroundStyle(.primary400)
                        .rotationEffect(.degrees(viewModel.rotation))
                        .offset(y: viewModel.getRequestInProgress ? 0 : min(-safeArea.top - 65 + offsetY, 0))
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(viewModel.drug.name)
                            .font(.system(size: 30 - (progress * 4)))
                            .fontWeight(.bold)
                            .foregroundStyle(.grey600)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .scaleEffect(
                                1 - (progress * 0.25),
                                anchor: .leading
                            )
                        
                        Text("10 Tablets")
                            .foregroundStyle(.grey500)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.tags, id: \.hashValue) { tag in
                                DrugChip(
                                    role: tag.role,
                                    text: tag.text,
                                    hintTitle: tag.hintTitle,
                                    hintText: tag.hintText
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                    }
                }
                .padding(.top, 64)
                .padding(.bottom, 16)
            }
            .frame(height: (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
        .shadow(
            color: .Primary400.opacity(0.24),
            radius: 8,
            x: 0,
            y: 2
        )
    }
}

#Preview {
    DrugView(drug: .constant(allDrugs[0]), drugViewVisible: .constant(true))
}
