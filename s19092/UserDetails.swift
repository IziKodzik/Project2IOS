//
//  UserDetails.swift
//  s19092
//
//  Created by kasia on 25/01/2021.
//

import UIKit

struct UserDetails: Decodable {
    
    enum Role :String, Decodable{
        
        case admin = "admin"
        case moderator = "moderator"
        case student = "student"
        case teacher = "teacher"
        case vip = "VIP"
        
    
        var image: UIImage {
            let icon:UIImage?
            switch self {
            case .admin:
               icon = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
                
            case .vip:
                icon = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            case .teacher:
                icon = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
            case .student:
                icon = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            case .moderator:
                icon = UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
            }
            return icon!
            
        }
    }
    let name: String
    let role: Role
    let university: String
    let phoneNumber: Int?
    let email: String?
    let id: Int
    let gender: String?
}
