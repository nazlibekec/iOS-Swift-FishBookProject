//
//  ViewController.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 21.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //Add NavigationBar Button
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
    
        
    }
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

}

