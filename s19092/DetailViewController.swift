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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        reloadUser()
    }
    
    func reloadUser(){
         guard let user = user else {
            return
        }
        AF.request("http://192.168.1.12:8080/api/user/detail?name=\(user.name)").responseJSON { response in
            if let error = response.error{
                self.presentError(error)
            }
       
            if let data = response.data {
                   do{
                    let user = try JSONDecoder().decode(UserDetails.self, from: data)
                    self.nameLabel.text = user.name
                
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
