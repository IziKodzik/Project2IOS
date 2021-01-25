//
//  AboutViewController.swift
//  s19092
//
//  Created by kasia on 25/01/2021.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    @IBOutlet weak var guardsView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guardsView.layer.cornerRadius = 10
    }
    
    @IBAction func okDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
