//
//  Drug.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Drug expiration state enum
enum E_DRUG_EXPIRY_STATE{
    case    not, soon, expired
}

/// Drug structure
struct Drug : Codable, Identifiable {
    var id: Int
    var name: String
    var location: Folder?
    var complement: String?
    var strength: String?
    var form: Form?
    var package: String?
    var route: Route?
    var dosage: Dosage?
    var pharm_class: PharmClass?
    var organization: Organization?
    var organization_country: Country?
    var actual_organization: Organization?
    var actual_organization_country: Country?
    var concurrent_import: String?
    var concurrent_import_organization: Organization?
    var concurrent_import_country: Country?
    var registration_status: RegistraionStatus?
    var valid_till: Date?
    var present_till: Date?
    var unlimited_registration: String?
    var registration_number: String?
    var registration_procedure: RegistrationProcedure?
    var registration_name: String?
    var legal_registration_base: LegalRegistrationBase?
    var source: Source?
    var daily_amount: Double?
    var daily_unit: Unit?
    var daily_count: Double?
    var dispense: Dispense?
    var addiction: Addiction?
    var doping: Doping?
    var hormones: Hormone?
    var supplied: String?
    var EAN: String?
    var brail_sign: String?
    var expiration: Int?
    var expiration_period: String?
    var mrp_number: String?
    var safety_element: String?
    var user_created: User
    var user_updated: User?
    var date_created: String
    var date_updated: String?
    var expiration_date: Date
    var count: String
    var expiry_state: E_DRUG_EXPIRY_STATE {
        get {
            let currentDate = Date()
            let fourMonthsFromNow = Calendar.current.date(byAdding: .month, value: 6, to: currentDate) ?? Date()
            
            if expiration_date < currentDate {
                return .expired
            } else if expiration_date < fourMonthsFromNow {
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
        case pharm_class
        case organization
        case organization_country
        case actual_organization
        case actual_organization_country
        case concurrent_import
        case concurrent_import_organization
        case concurrent_import_country
        case registration_status
        case valid_till
        case present_till
        case unlimited_registration
        case registration_number
        case registration_procedure
        case registration_name
        case legal_registration_base
        case source
        case daily_amount
        case daily_unit
        case daily_count
        case dispense
        case addiction
        case doping
        case hormones
        case supplied
        case EAN
        case brail_sign
        case expiration
        case expiration_period
        case mrp_number
        case safety_element
        case user_created
        case user_updated
        case date_created
        case date_updated
        case expiration_date
        case count
    }

    /// Init drug from decoder (used for API response parsing)
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)!
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!
        
        if let location = try? values.decodeIfPresent(Folder.self, forKey: .location) {
            self.location = location
        } else if let location = try? values.decodeIfPresent(String.self, forKey: .location) {
            self.location = .init(id: location)
        } else {
            self.location = nil
        }
        
        self.complement = try? values.decodeIfPresent(String.self, forKey: .complement)
        self.strength = try? values.decodeIfPresent(String.self, forKey: .strength)
        
        if let form = try? values.decodeIfPresent(Form.self, forKey: .form) {
            self.form = form
        } else if let form = try? values.decodeIfPresent(String.self, forKey: .form) {
            self.form = .init(form: form)
        } else {
            self.form = Form.empty
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
        
        if let pharm_class = try? values.decodeIfPresent(PharmClass.self, forKey: .pharm_class) {
            self.pharm_class = pharm_class
        } else if let pharm_class = try? values.decodeIfPresent(String.self, forKey: .pharm_class) {
            self.pharm_class = .init(code: pharm_class)
        } else {
            self.pharm_class = nil
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
        
        if let actual_organization = try? values.decodeIfPresent(Organization.self, forKey: .actual_organization) {
            self.actual_organization = actual_organization
        } else if let actual_organization = try? values.decodeIfPresent(String.self, forKey: .actual_organization) {
            self.actual_organization = .init(code: actual_organization)
        } else {
            self.actual_organization = nil
        }
        
        if let actual_organization_country = try? values.decodeIfPresent(Country.self, forKey: .actual_organization_country) {
            self.actual_organization_country = actual_organization_country
        } else if let actual_organization_country = try? values.decodeIfPresent(String.self, forKey: .actual_organization_country) {
            self.actual_organization_country = .init(code: actual_organization_country)
        } else {
            self.actual_organization_country = nil
        }
        
        self.concurrent_import = try values.decodeIfPresent(String.self, forKey: .concurrent_import) ?? nil
        
        if let concurrent_import_organization = try? values.decodeIfPresent(Organization.self, forKey: .concurrent_import_organization) {
            self.concurrent_import_organization = concurrent_import_organization
        } else if let concurrent_import_organization = try? values.decodeIfPresent(String.self, forKey: .concurrent_import_organization) {
            self.concurrent_import_organization = .init(code: concurrent_import_organization)
        } else {
            self.concurrent_import_organization = nil
        }
        
        if let concurrent_import_country = try? values.decodeIfPresent(Country.self, forKey: .concurrent_import_country) {
            self.concurrent_import_country = concurrent_import_country
        } else if let concurrent_import_country = try? values.decodeIfPresent(String.self, forKey: .concurrent_import_country) {
            self.concurrent_import_country = .init(code: concurrent_import_country)
        } else {
            self.concurrent_import_country = nil
        }
        
        if let registration_status = try? values.decodeIfPresent(RegistraionStatus.self, forKey: .registration_status) {
            self.registration_status = registration_status
        } else if let registration_status = try? values.decodeIfPresent(String.self, forKey: .registration_status) {
            self.registration_status = .init(code: registration_status)
        } else {
            self.registration_status = nil
        }
        
        if let valid_till = try? values.decodeIfPresent(String.self, forKey: .valid_till) {
            self.valid_till = dateFormatter.date(from: valid_till) ?? Date()
        } else {
            self.valid_till = nil
        }
        
        if let present_till = try? values.decodeIfPresent(String.self, forKey: .present_till) {
            self.present_till = dateFormatter.date(from: present_till) ?? Date()
        } else {
            self.present_till = nil
        }
        
        self.unlimited_registration = try? values.decodeIfPresent(String.self, forKey: .unlimited_registration)
        self.registration_number = try? values.decodeIfPresent(String.self, forKey: .registration_number)
        
        if let registration_procedure = try? values.decodeIfPresent(RegistrationProcedure.self, forKey: .registration_procedure) {
            self.registration_procedure = registration_procedure
        } else if let registration_procedure = try? values.decodeIfPresent(String.self, forKey: .registration_procedure) {
            self.registration_procedure = .init(code: registration_procedure)
        } else {
            self.registration_procedure = nil
        }
        
        self.registration_name = try? values.decodeIfPresent(String.self, forKey: .registration_name)
        
        if let legal_registration_base = try? values.decodeIfPresent(LegalRegistrationBase.self, forKey: .legal_registration_base) {
            self.legal_registration_base = legal_registration_base
        } else if let legal_registration_base = try? values.decodeIfPresent(String.self, forKey: .legal_registration_base) {
            self.legal_registration_base = .init(code: legal_registration_base)
        } else {
            self.legal_registration_base = nil
        }
        
        if let source = try? values.decodeIfPresent(Source.self, forKey: .source) {
            self.source = source
        } else if let source = try? values.decodeIfPresent(String.self, forKey: .source) {
            self.source = .init(code: source)
        } else {
            self.source = nil
        }
        
        self.daily_amount = try? values.decodeIfPresent(Double.self, forKey: .daily_amount)
        
        if let daily_unit = try? values.decodeIfPresent(Unit.self, forKey: .daily_unit) {
            self.daily_unit = daily_unit
        } else if let daily_unit = try? values.decodeIfPresent(String.self, forKey: .daily_unit) {
            self.daily_unit = .init(unit: daily_unit)
        } else {
            self.daily_unit = nil
        }
        
        self.daily_count = try? values.decodeIfPresent(Double.self, forKey: .daily_amount)
        
        if let dispense = try? values.decodeIfPresent(Dispense.self, forKey: .dispense) {
            self.dispense = dispense
        } else if let dispense = try? values.decodeIfPresent(String.self, forKey: .dispense) {
            self.dispense = .init(code: dispense)
        } else {
            self.dispense = nil
        }
        
        if let addiction = try? values.decodeIfPresent(Addiction.self, forKey: .addiction) {
            self.addiction = addiction
        } else if let addiction = try? values.decodeIfPresent(String.self, forKey: .addiction) {
            self.addiction = .init(code: addiction)
        } else {
            self.addiction = nil
        }
        
        if let doping = try? values.decodeIfPresent(Doping.self, forKey: .doping) {
            self.doping = doping
        } else if let doping = try? values.decodeIfPresent(String.self, forKey: .doping) {
            self.doping = .init(doping: doping)
        } else {
            self.doping = nil
        }
        
        if let hormones = try? values.decodeIfPresent(Hormone.self, forKey: .hormones) {
            self.hormones = hormones
        } else if let hormones = try? values.decodeIfPresent(String.self, forKey: .hormones) {
            self.hormones = .init(code: hormones)
        } else {
            self.hormones = nil
        }
        
        self.supplied = try? values.decodeIfPresent(String.self, forKey: .supplied)
        self.EAN = try? values.decodeIfPresent(String.self, forKey: .EAN)
        self.brail_sign = try? values.decodeIfPresent(String.self, forKey: .brail_sign)
        self.expiration = try? values.decodeIfPresent(Int.self, forKey: .expiration)
        self.expiration_period = try? values.decodeIfPresent(String.self, forKey: .expiration_period)
        self.mrp_number = try? values.decodeIfPresent(String.self, forKey: .mrp_number)
        self.safety_element = try? values.decodeIfPresent(String.self, forKey: .safety_element)
        
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
        
        if let expiration_date = try? values.decodeIfPresent(String.self, forKey: .expiration_date) {
            self.expiration_date = dateFormatter.date(from: expiration_date) ?? Date()
        } else {
            throw DecodingError.typeMismatch(
                [String : Any].self,
                .init(codingPath: [CodingKeys.self.expiration_date], debugDescription: "")
            )
        }
        
        self.count = try values.decodeIfPresent(String.self, forKey: .count)!
    }

    /// Init drug with id, name, complement, expiration date and location
    /// - Parameters:
    ///   - id: drug id
    ///   - name: drug name
    ///   - complement: drug complement
    ///   - expiration_date: drug expiration date
    init(id: Int, name: String, complement: String, expiration_date: String) {
        self.id = id
        self.name = name
        self.complement = complement
        self.route = .init(route: "POR", name: "Oral")
        self.location = .allFolder
        self.date_created = ""
        self.user_created = .init(id: "f4aca9df-fb67-4f14-b321-cdbf3c985383")
        self.expiration_date = dateFormatter.date(from: expiration_date) ?? Date()
        self.form = Form.empty
        self.count = ""
    }

    /// Init drug with id, name, complement, expiration date and location
    /// - Parameters:
    ///   - id: drug id
    ///   - name: drug name
    ///   - complement: drug complement
    ///   - expiration_date: drug expiration date
    ///   - location: drug folder
    init(id: Int, name: String, complement: String, expiration_date: String, location: Folder?) {
        self.id = id
        self.name = name
        self.complement = complement
        self.route = .init(route: "POR", name: "Oral")
        self.location = location
        self.date_created = ""
        self.user_created = .init(id: "f4aca9df-fb67-4f14-b321-cdbf3c985383")
        self.expiration_date = dateFormatter.date(from: expiration_date) ?? Date()
        self.form = Form.empty
        self.count = ""
    }
    
    var hasGeneral: Bool {
        return self.strength != nil || self.form != nil || self.package != nil || self.route != nil || self.complement != nil || self.dosage != nil || self.pharm_class != nil
    }
    
    var hasSources: Bool {
        return self.organization != nil || self.organization_country != nil || self.actual_organization != nil || self.actual_organization_country != nil || self.concurrent_import != nil || self.concurrent_import_country != nil || self.concurrent_import_organization != nil
    }
    
    var hasRegistration: Bool {
        return self.registration_status != nil || self.valid_till != nil || self.present_till != nil || self.unlimited_registration != nil || self.registration_number != nil || self.registration_procedure != nil || self.registration_name != nil || self.legal_registration_base != nil
    }
    
    var hasDispense: Bool {
        return self.daily_amount != nil || self.daily_unit != nil || self.daily_count != nil || self.dispense != nil
    }
    
    var hasEffects: Bool {
        return self.addiction != nil || self.doping != nil || self.hormones != nil
    }
    
    var hasMisc: Bool {
        return self.supplied != nil || self.EAN != nil || self.brail_sign != nil || self.expiration != nil || self.expiration_period != nil || self.mrp_number != nil || self.safety_element != nil
    }

    /// Get empty drug
    static var empty: Drug {
        get {
            return .init(id: 0, name: "", complement: "", expiration_date: "", location: nil)
        }
    }
}

typealias GetAllUsersDrugsResponse = [Drug]

typealias GetUsersDrugResponse = Drug

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}

let allDrugs: [Drug] = [
    .init(id: 1, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 10 II", expiration_date: "2022-10-12"),
    .init(id: 2, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 20 II", expiration_date: "2025-10-12"),
    .init(id: 3, name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 24 II", expiration_date: "2023-12-12"),
    .init(id: 4, name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 10", expiration_date: "2022-10-12"),
    .init(id: 5, name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 5", expiration_date: "2022-10-12"),
    .init(id: 6, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 12", expiration_date: "2022-10-12"),
    .init(id: 7, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 16", expiration_date: "2022-10-12"),
    .init(id: 8, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 20", expiration_date: "2022-10-12"),
    .init(id: 9, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 24", expiration_date: "2022-10-12"),
    .init(id: 10, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 30", expiration_date: "2022-10-12"),
    .init(id: 11, name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 100", expiration_date: "2022-10-12"),
    .init(id: 12, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 8", expiration_date: "2022-10-12"),
    .init(id: 13, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 16", expiration_date: "2022-10-12"),
    .init(id: 14, name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 100", expiration_date: "2022-10-12"),
]
