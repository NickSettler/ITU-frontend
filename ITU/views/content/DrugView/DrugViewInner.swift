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
                                    text: viewModel.drug.expiration_date.formatted(.dateTime.month(.twoDigits).year()),
                                    hintTitle: "Expirtion date",
                                    hintText: viewModel.expiryDateHint
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
                        
                        if viewModel.drug.hasGeneral {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("General")
                                
                                VStack(spacing: toastGap) {
                                    if let strength = viewModel.drug.strength {
                                        DrugToast(
                                            role: .success,
                                            title: "Strength",
                                            text: strength,
                                            hintTitle: "Strength",
                                            hintText: "The term strength refers to the concentration or dosage of the active ingredient(s) in a medication."
                                        )
                                    }
                                    
                                    if let form = viewModel.drug.form?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Form",
                                            text: form,
                                            hintTitle: "Form",
                                            hintText: "A drug form is just the way medicine comes. It could be a pill you swallow, a shot you get, or even a cream you put on your skin. It's like the package that helps the medicine work the best for you."
                                            
                                        )
                                    }
                                    
                                    if let route = viewModel.drug.route?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Route",
                                            text: route,
                                            hintTitle:"Route",
                                            hintText:"The route is how you take or apply a medicine. It's like the path the medicine follows to get into your body and start working."
                                            
                                        )
                                    }
                                    
                                    if let package = viewModel.drug.package {
                                        DrugToast(
                                            role: .success,
                                            title: "Package",
                                            text: package,
                                            hintTitle: "Package",
                                            hintText: "A package is like the wrapping of your medicine. It's what keeps it safe and easy to use."
                                        )
                                    }
                                    
                                    if let dosage = viewModel.drug.dosage?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Dosage",
                                            text: dosage,
                                            hintTitle: "Dosage",
                                            hintText: "Dosage is simply the amount of medicine you're supposed to take or use. It's like following a recipe – it tells you how much of the medicine will be effective and safe for your body. "
                                            
                                        )
                                    }
                                    
                                    if let pharm_class = viewModel.drug.pharm_class?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Drug class",
                                            text: pharm_class,
                                            hintTitle: "Drug Class",
                                            hintText: "Drug class is like putting medicines into groups based on how they work or what they treat. It's a way to organize them. For example, pain relievers might be in one class, while antibiotics are in another."
                                            
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        if viewModel.drug.hasSources {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Sources")
                                
                                VStack(spacing: toastGap) {
                                    if let organization = viewModel.drug.organization?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Marketing authorization holder",
                                            text: organization,
                                            hintTitle: "Marketing authorization holder",
                                            hintText: "The marketing authorization holder is the company or organization that has been given the official approval to market and sell a specific medicine or medical product."
                                        )
                                    }
                                    
                                    if let organization_country = viewModel.drug.organization_country?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Marketing authorization holder country",
                                            text: organization_country
                                        )
                                    }
                                    
                                    if let actual_organization = viewModel.drug.actual_organization?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Manufacturer",
                                            text: actual_organization
                                        )
                                    }
                                    
                                    if let actual_organization_country = viewModel.drug.actual_organization_country?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Manufacturer country",
                                            text: actual_organization_country,
                                            hintTitle: "Manufacturer country",
                                            hintText: "A manufacturer is a company or facility that produces or makes a product, including medicines."
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
                                    
                                    if let source = viewModel.drug.source?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Source",
                                            text: source
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        if viewModel.drug.hasRegistration {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Registration")
                                
                                if let registration_status = viewModel.drug.registration_status?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Registration status",
                                        text: registration_status,
                                        hintTitle: "Registration status",
                                        hintText: "Registration status is like the permission a medicine gets to be sold. If it's approved or registered, it means it passed the safety and effectiveness checks by the authorities. If it's pending, it's still being reviewed."
                                        
                                    )
                                }
                                
                                if let valid_till = viewModel.drug.valid_till {
                                    DrugToast(
                                        role: .success,
                                        title: "Valid till",
                                        text: valid_till.formatted(.dateTime.month(.twoDigits).year())
                                    )
                                }
                                
                                if let present_till = viewModel.drug.present_till {
                                    DrugToast(
                                        role: .success,
                                        title: "Present till",
                                        text: present_till.formatted(.dateTime.month(.twoDigits).year())
                                    )
                                }
                                
                                if let unlimited_registration = viewModel.drug.unlimited_registration {
                                    DrugToast(
                                        role: .success,
                                        title: "Unlimited Registration",
                                        text: unlimited_registration
                                    )
                                }
                                
                                if let registration_procedure = viewModel.drug.registration_procedure?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Registration procedure",
                                        text: registration_procedure
                                    )
                                }
                                
                                if let registration_name = viewModel.drug.registration_name {
                                    DrugToast(
                                        role: .success,
                                        title: "Registration name",
                                        text: registration_name
                                    )
                                }
                                
                                if let legal_registration_base = viewModel.drug.legal_registration_base?.name {
                                    DrugToast(
                                        role: .success,
                                        title: "Legal registration base",
                                        text: legal_registration_base
                                    )
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        if viewModel.drug.hasDispense {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Dispense")
                                
                                VStack(spacing: toastGap) {
                                    if let daily_amount = viewModel.drug.daily_amount {
                                        DrugToast(
                                            role: .success,
                                            title: "Daily amount",
                                            text: daily_amount.formatted()
                                        )
                                    }
                                    
                                    if let daily_unit = viewModel.drug.daily_unit?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Daily unit",
                                            text: daily_unit
                                        )
                                    }
                                    
                                    if let daily_count = viewModel.drug.daily_count {
                                        DrugToast(
                                            role: .success,
                                            title: "Daily count",
                                            text: daily_count.formatted()
                                        )
                                    }
                                    
                                    if let dispense = viewModel.drug.dispense?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Dispense",
                                            text: dispense
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        if viewModel.drug.hasEffects {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Effects")
                                
                                VStack(spacing: toastGap) {
                                    if let addiction = viewModel.drug.addiction?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Addiction",
                                            text: addiction
                                        )
                                    }
                                    
                                    if let doping = viewModel.drug.doping?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Doping",
                                            text: doping
                                        )
                                    }
                                    
                                    if let hormones = viewModel.drug.hormones?.name {
                                        DrugToast(
                                            role: .success,
                                            title: "Hormones",
                                            text: hormones
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        if viewModel.drug.hasMisc {
                            VStack(alignment: .leading, spacing: subSectionGap) {
                                SectionTitle("Miscellaneous")
                                
                                VStack(spacing: toastGap) {
                                    if let supplied = viewModel.drug.supplied {
                                        DrugToast(
                                            role: .success,
                                            title: "Supplied",
                                            text: supplied
                                        )
                                    }
                                    
                                    if let EAN = viewModel.drug.EAN {
                                        DrugToast(
                                            role: .success,
                                            title: "EAN",
                                            text: EAN
                                        )
                                    }
                                    
                                    if let brail_sign = viewModel.drug.brail_sign {
                                        DrugToast(
                                            role: .success,
                                            title: "Brail Sign",
                                            text: brail_sign
                                        )
                                    }
                                    
                                    if let expiration = viewModel.drug.expiration {
                                        DrugToast(
                                            role: .success,
                                            title: "Expiration",
                                            text: expiration.formatted()
                                        )
                                    }
                                    
                                    if let expiration_period = viewModel.drug.expiration_period {
                                        DrugToast(
                                            role: .success,
                                            title: "Expiration Period",
                                            text: expiration_period
                                        )
                                    }
                                    
                                    if let mrp_number = viewModel.drug.mrp_number {
                                        DrugToast(
                                            role: .success,
                                            title: "MRP number",
                                            text: mrp_number
                                        )
                                    }
                                    
                                    if let safety_element = viewModel.drug.safety_element {
                                        DrugToast(
                                            role: .success,
                                            title: "Safety Element",
                                            text: safety_element
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
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
                        
                        Text("\(viewModel.drug.count)")
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
