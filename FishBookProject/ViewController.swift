//
//  ViewController.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 20.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
    
    }
    
    
    @objc func addButton(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

}

