//  BackgroundColor.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import Foundation

struct BackGColor: Hashable,Codable{
   
    var alpha : Double
    var blue  : Double
    var green : Double
    var red   : Double
    
    enum CodingKeys: String,CodingKey {
        case alpha = "alpha"
        case blue = "blue"
        case green = "green"
        case red = "red"
    }
}
