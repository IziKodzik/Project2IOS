//
//  MenuViewController.swift
//  s19092
//
//  Created by kasia on 25/01/2021.
//

import UIKit

class MenuViewController :UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func listDidTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowList", sender: nil)
    }
    @IBAction func aboutDidTap(_ sender: Any) {
        performSegue(withIdentifier: "ShowAbout", sender: nil)
    }
    
    
    

    
}
