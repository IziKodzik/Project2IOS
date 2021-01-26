//
//  UsersViewController.swift
//  s19092
//
//  Created by kasia on 24/01/2021.
//

import UIKit
import Alamofire
class UsersViewController: UITableViewController, UISearchResultsUpdating{
   
    
    var filteredUsers: [User] = []
    var resultSearchController = UISearchController()
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredUsers.removeAll(keepingCapacity:false)
        if let text = searchController.searchBar.text {
            let filteredUsers = loadedUsers.filter({$0.name.prefix(text.count) == text})
            self.filteredUsers = filteredUsers
        }
        tableView.reloadData()
    }
    

    
    var loadedUsers: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.isActive = false
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.obscuresBackgroundDuringPresentation = true
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadUsers()
       
        
    }
    @IBAction func didTapArrow(_ sender: Any) {
        reloadUsers()
    }
    func reloadUsers(){
        AF.request("https://spring-user.herokuapp.com/api/user/all").responseJSON { response in
            if let error = response.error{
                self.presentError(error)
            }
       
            if let data = response.data {
                   do{
                    let users = try JSONDecoder().decode([User].self, from: data)
                    self.loadedUsers = users.sorted {$0.role < $1.role} ;
                    self.tableView.reloadData()
                }catch {
                    self.presentError(error)
                }
            }
        }
        
    }
    func presentError(_ error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel))
    alert.addAction(UIAlertAction(title: "Reload", style: .default) {_ in self.reloadUsers()})
        self.present(alert,animated: true)
//    alert.addAction(UIAlertAction(title: "Contact administrator",style: .default))

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        if(resultSearchController.isActive){
            return filteredUsers.count
        }
        return loadedUsers.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView
        (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableCell
        if !resultSearchController.isActive {
            cell.nameLabel.text = loadedUsers[indexPath.row].name
            cell.roleLabel.text = loadedUsers[indexPath.row].role
        }else{
            cell.nameLabel.text = filteredUsers[indexPath.row].name
            cell.roleLabel.text = filteredUsers[indexPath.row].role
        }
        return cell
                
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier {
        case "ShowDetail":
                let viewController = segue.destination as! DetailViewController
                if let indexPath = tableView.indexPathForSelectedRow{
                    if(indexPath.row < loadedUsers.count){
                        viewController.user = loadedUsers[indexPath.row]
                    }
                }
            default:
                print("ss")
        }
        
    }
}




class UserTableCell : UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
}
