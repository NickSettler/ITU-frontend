//
//  Drug.swift
//  ITU
//
//  Created by Nikita Moiseev on 02.11.2023.
//

import Foundation

struct Drug : Codable, Identifiable {
    var id: Int
    var name: String
    var location: Folder
    var complement: String?
    var strength: String?
    var form: Form?
    var package: String?
    var route: Route?
    var dosage: Dosage?
    var organization: Organization?
    var organization_country: Country?
    var user_created: User
    var user_updated: User?
    var date_created: String
    var date_updated: String?
    var expiry_date: String
    var expiry_state: E_drug_exp_state {
        get {
            let currentDate = Date()
            let fourMonthsFromNow = Calendar.current.date(byAdding: .month, value: 6, to: currentDate) ?? Date()
            let expiryDate = dateFormatter.date(from: expiry_date) ?? currentDate
            if expiryDate < currentDate {
                       return .expired
                   } else if expiryDate < fourMonthsFromNow {
                       return .soon
                   } else {
                       return .not
                   }
        }
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case location
        case complement
        case strength
        case form
        case package
        case route
        case dosage
        case organization
        case organization_country
        case user_created
        case user_updated
        case date_created
        case date_updated
        case expiry_date
    }
    
    enum E_drug_exp_state{
        case    not, soon, expired
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)!
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!
        
        if let location = try? values.decodeIfPresent(Folder.self, forKey: .location) {
            self.location = location
        } else if let location = try? values.decodeIfPresent(String.self, forKey: .location) {
            self.location = .init(id: location)
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.location], debugDescription: "")
            )
        }
        
        self.complement = try? values.decodeIfPresent(String.self, forKey: .complement)
        self.strength = try? values.decodeIfPresent(String.self, forKey: .strength)
        
        if let form = try? values.decodeIfPresent(Form.self, forKey: .form) {
            self.form = form
        } else if let form = try? values.decodeIfPresent(String.self, forKey: .form) {
            self.form = .init(form: form)
        } else {
            self.form = nil
        }
        
        self.package = try? values.decodeIfPresent(String.self, forKey: .package)
        
        if let route = try? values.decodeIfPresent(Route.self, forKey: .route) {
            self.route = route
        } else if let route = try? values.decodeIfPresent(String.self, forKey: .route) {
            self.route = .init(route: route)
        } else {
            self.route = nil
        }
        
        if let dosage = try? values.decodeIfPresent(Dosage.self, forKey: .dosage) {
            self.dosage = dosage
        } else if let dosage = try? values.decodeIfPresent(String.self, forKey: .dosage) {
            self.dosage = .init(form: dosage)
        } else {
            self.dosage = nil
        }
        
        if let organization = try? values.decodeIfPresent(Organization.self, forKey: .organization) {
            self.organization = organization
        } else if let organization = try? values.decodeIfPresent(String.self, forKey: .organization) {
            self.organization = .init(code: organization)
        } else {
            self.organization = nil
        }
        
        if let organization_country = try? values.decodeIfPresent(Country.self, forKey: .organization_country) {
            self.organization_country = organization_country
        } else if let organization_country = try? values.decodeIfPresent(String.self, forKey: .organization_country) {
            self.organization_country = .init(code: organization_country)
        } else {
            self.organization_country = nil
        }
        
        if let user_created = try? values.decodeIfPresent(User.self, forKey: .user_created) {
            self.user_created = user_created
        } else if let user_created = try? values.decodeIfPresent(String.self, forKey: .user_created) {
            self.user_created = .init(id: user_created)
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.user_created], debugDescription: "")
            )
        }
        
        if let user_updated = try? values.decodeIfPresent(User.self, forKey: .user_updated) {
            self.user_updated = user_updated
        } else if let user_updated = try? values.decodeIfPresent(String.self, forKey: .user_updated) {
            self.user_updated = .init(id: user_updated)
        } else {
            self.user_updated = nil
        }
        
        self.date_created = try values.decodeIfPresent(String.self, forKey: .date_created)!
        self.date_updated = try values.decodeIfPresent(String.self, forKey: .date_updated) ?? nil
        
        self.expiry_date = try values.decodeIfPresent(String.self, forKey: .expiry_date)!

    }
    
    init(id: Int, name: String, complement: String, expiry_date: String) {
        self.id = id
        self.name = name
        self.complement = complement
        self.location = .allFolder
        self.date_created = ""
        self.user_created = .init(id: "f4aca9df-fb67-4f14-b321-cdbf3c985383")
        self.expiry_date = expiry_date
    }
}

typealias GetAllUsersDrugsResponse = [Drug]

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}

let allDrugs: [Drug] = [
    .init(id: 1, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 10 II", expiry_date: "2022-10-12"),
    .init(id: 2, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 20 II", expiry_date: "2025-10-12"),
    .init(id: 3, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 24 II", expiry_date: "2023-12-12"),
    .init(id: 4, name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 10", expiry_date: "2022-10-12"),
    .init(id: 5, name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 5", expiry_date: "2022-10-12"),
    .init(id: 6, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 12", expiry_date: "2022-10-12"),
    .init(id: 7, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 16", expiry_date: "2022-10-12"),
    .init(id: 8, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 20", expiry_date: "2022-10-12"),
    .init(id: 9, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 24", expiry_date: "2022-10-12"),
    .init(id: 10, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 30", expiry_date: "2022-10-12"),
    .init(id: 11, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 100", expiry_date: "2022-10-12"),
    .init(id: 12, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 8", expiry_date: "2022-10-12"),
    .init(id: 13, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 16", expiry_date: "2022-10-12"),
    .init(id: 14, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 100", expiry_date: "2022-10-12"),
]
