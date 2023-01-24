//
//  ViewController.swift
//  FishBookProject
//
//  Created by Nazlı Bekeç on 21.01.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabelView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        
        //Add NavigationBar Button
        navigationController?.navigationBar.topItem?.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
       
        
        getData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    
        @objc func getData(){
            
            //Verilerin tekrarlanmasını engeller.
            nameArray.removeAll(keepingCapacity: false)
            idArray.removeAll(keepingCapacity: false)
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            fetchRequest.returnsObjectsAsFaults = false
            
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name")  as? String {
                        self.nameArray.append(name)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    //yeni gelen veri var güncelle demek.
                    self.tabelView.reloadData()
                    
                }
                        
            } catch {
                print("error")
            }
            
            
            
        }

    
    
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
}

