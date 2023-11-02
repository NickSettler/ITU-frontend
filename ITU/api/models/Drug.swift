//
//  Drug.swift
//  ITU
//
//  Created by Никита Моисеев on 02.11.2023.
//

import Foundation

struct Drug : Decodable {
    var id: String
    var name: String
    var complement: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case complement
    }
}

let allDrugs: [Drug] = [
    .init(id: "1", name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 10 II"),
    .init(id: "2", name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 20 II"),
    .init(id: "3", name: "PARACETAMOL AUROVITAS", complement: "500MG TBL NOB 24 II"),
    .init(id: "4", name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 10"),
    .init(id: "5", name: "PARACETAMOL STADA", complement: "600MG POR PLV SOL SCC 5"),
    .init(id: "6", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 12"),
    .init(id: "7", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 16"),
    .init(id: "8", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 20"),
    .init(id: "9", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 24"),
    .init(id: "10", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 30"),
    .init(id: "11", name: "PARACETAMOL ZENTIVA", complement: "500MG TBL NOB 100"),
    .init(id: "9", name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 8"),
    .init(id: "10", name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 16"),
    .init(id: "11", name: "PARACETAMOL ZENTIVA", complement: "1000MG TBL NOB 100"),
]
