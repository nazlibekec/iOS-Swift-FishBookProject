//
//  DetailsVC.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 21.01.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var lifeTimeText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if chosenPainting != ""{
            
            // Save butonunu pasife getir.
            
            saveButton.isEnabled = false
            
            //Core Data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = chosenPaintingId?.uuidString
            
            // formata göre veri çekme işlemi  -Filtreleme
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            // çektiğimiz id yi gösterme işlemi
            
            do{
               let results = try context.fetch(fetchRequest)
            
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        if let lifeTime = result.value(forKey: "lifetime") as? Int {
                            lifeTimeText.text = String(lifeTime)
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            imageView.image = UIImage(data: imageData)
                        }
                    }
                }
            } catch {
                print("error")
            }
            
        } else {
            
            saveButton.isEnabled = false
            saveButton.isHidden = false
        }
        
        
        //Recognizer
        //Hide Keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        //İmage Select
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //Add Image
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        
        //Görsel seçtiğinde Save butonunu aktif et
        
        saveButton.isEnabled = true
        
        self.dismiss(animated: true, completion: nil)
    }
        

    @IBAction func saveClickedButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context!)
        
        
        //Attributes
        
        newPainting.setValue(nameText.text!, forKey: "name")
        
        if let lifeTime = Int(lifeTimeText.text!) {
            newPainting.setValue(lifeTime, forKey: "lifetime")
        }
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context?.save()
            print("success")
        } catch {
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
}
