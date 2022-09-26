//  User.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import Foundation
import UIKit

struct User:Identifiable, Codable {
    
    var id: Int
    var name: String
    var photoURL: String
    
    init(){
        id = -1
        name = ""
        photoURL = ""
    }
    
}
