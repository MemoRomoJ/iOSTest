//  GraphModel.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import Foundation

struct GraphModel: Decodable {
    let reporte: [Reporte]
    let empresas: [Empresa]
}
struct Reporte:Decodable {
    let valor: String
    let cantidad: String
    
    enum CodingKeys: String, CodingKey {
        case valor = "valor"
        case cantidad = "cantidad"
    }
}
struct Empresa: Decodable {
    let nombre: String
    let porcentaje: Int
    
    enum CodingKeys: String, CodingKey {
        case nombre = "nombre"
        case porcentaje = "porcentaje"
    }
}
