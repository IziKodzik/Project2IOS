//
//  UserDetails.swift
//  s19092
//
//  Created by kasia on 25/01/2021.
//

import Foundation

struct UserDetails: Decodable {
    
    enum Role :String, Decodable{
        
        
        
        case admin = "admin"
        case moderator = "moderator"
        case student = "student"
        case teacher = "teacher"
        case vip = "VIP"
        
    }
    let name: String
    let role: Role
    let university: String
    let phoneNumber: Int
    let email: String
    let id: Int
}
