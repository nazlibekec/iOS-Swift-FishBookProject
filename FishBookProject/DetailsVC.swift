//
//  DetailsVC.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 20.01.2023.
//

import UIKit

class DetailsVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lifeTimeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        //Recognizer
        //Keyboard closed.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //Select Image
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
        
    }
    
    @objc func selectImage(){
        
       let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary  //galeriden aç
        picker.allowsEditing = true //seçtiği görseli değiştirebilir.
        present(picker, animated: true, completion: nil)
        
    }
    
    //görseli seçince ne olacağı
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //Keyboard closed.
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
    }
    
}
