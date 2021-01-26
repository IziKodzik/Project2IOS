//
//  DetailViewController.swift
//  s19092
//
//  Created by kasia on 25/01/2021.
//

import Alamofire
import UIKit

class DetailViewController : UIViewController{
    
    var user: User?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        reloadUser()
    }
    
    func reloadUser(){
         guard let user = user else {
            return
        }
        let name = user.name.replacingOccurrences(of: " ", with: "%20")
        AF.request("http://spring-user.herokuapp.com/api/user/detail?name=\(name)").responseJSON { response in
            if let error = response.error{
                self.presentError(error)
            }
       
            if let data = response.data {
                   do{
                    let user = try JSONDecoder().decode(UserDetails.self, from: data)
                    self.roleImage.image = user.role.image
                    self.nameLabel.text = user.name
                    self.roleLabel.text = user.role.rawValue
                    if let email = user.email{
                        self.emailLabel.text = "e-mail: \(email)"
                    }else{
                        self.emailLabel.text = "e-mail: has not been provided"
                    }
                    if let phoneNumber = user.phoneNumber {
                        self.phoneLabel.text = "phone nr: \(String(phoneNumber))"
                    }else{
                        self.phoneLabel.text = "phone has not been provided"
                    }
                    self.universityLabel.text = "university: \(user.university)"
                    if let gender = user.gender {
                        self.genderLabel.text = "gender: \(gender)"
                    }else{
                        self.genderLabel.text = "gender: has not been provided"
                    }
                    self.idLabel.text = "id: \(String(user.id))"
                }catch {
                    self.presentError(error)
                }
            }
        }
        
    }
    func presentError(_ error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel))
    alert.addAction(UIAlertAction(title: "Reload", style: .default) {_ in self.reloadUser()})
        self.present(alert,animated: true)
//    alert.addAction(UIAlertAction(title: "Contact administrator",style: .default))

    }
}
