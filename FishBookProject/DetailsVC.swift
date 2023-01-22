//
//  DetailsVC.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 21.01.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var lifeTimeText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Hide Keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    
    
    @IBAction func saveClickedButton(_ sender: Any) {
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}
