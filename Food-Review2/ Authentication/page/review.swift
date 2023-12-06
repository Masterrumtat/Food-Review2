

//
//  Review.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 16/11/2566 BE.
//

import UIKit
import FirebaseFirestore
import Firebase

class RestaurantTableViewController: UITableViewController {
    
    var restaurants: [DocumentSnapshot] = []          //DocumentSnapshot คือตัวแทนของเอกสารในฐานข้อมูล Firestore
    var Imgrest: [String] = []
    var imgPlist=ImgPlist()
    var typerest: [String] = []
    var openclose: [String] = []
    var collec: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=300
        
        // Call a function to fetch data from Firestore
        fetchDataFromFirestore()
        imgRest()
        typeRest()
        OpenClose()
        imgPlist.loadPlist(fname: "ImgRest")
    }
    
    // Function to fetch data from Firestore
    func fetchDataFromFirestore() {
        let db = Firestore.firestore()
        
        db.collection("restaurants2").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.restaurants = querySnapshot!.documents
                self.tableView.reloadData()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    // Implement UITableViewDataSource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restCell", for: indexPath) as! rest
        
        let restaurant = restaurants[indexPath.row]
        cell.nameRest.text = restaurant["name"] as? String
        cell.lbRest.text = restaurant["place"] as? String
        
        if indexPath.row < Imgrest.count {
            cell.Imgrest.image = UIImage(named: Imgrest[indexPath.row])
        } else {
            print("Index out of range for Imgrest array")
        }
        
        // Set other UI elements as needed
        
        return cell
    }
    
    // Function to load image names from plist
    func imgRest() {
        guard let link = Bundle.main.url(forResource: "nameRestimg", withExtension: "plist"),
              let testData = try? Data(contentsOf: link),
              let imgRestArray = try? PropertyListSerialization.propertyList(from: testData, options: [], format: nil) as? [String] else {
            print("Failed to load image names from plist.")
            return
        }
        
        Imgrest = imgRestArray
        print(Imgrest)
    }
    func typeRest() {
        guard let link = Bundle.main.url(forResource: "type", withExtension: "plist"),
              let testData = try? Data(contentsOf: link),
              let typeRestArray = try? PropertyListSerialization.propertyList(from: testData, options: [], format: nil) as? [String] else {
            print("Failed to load image names from plist.")
            return
        }
    
        typerest = typeRestArray
    }
    func OpenClose() {
        guard let link = Bundle.main.url(forResource: "open-close", withExtension: "plist"),
              let testData = try? Data(contentsOf: link),
              let OpenCloseArray = try? PropertyListSerialization.propertyList(from: testData, options: [], format: nil) as? [String] else {
            print("Failed to load image names from plist.")
            return
        }
    
        openclose = OpenCloseArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        if segue.identifier == "passdata" {
            if let vc = segue.destination as? reviewInfo {
                let rowClick = selectedIndexPath.row
                guard rowClick < restaurants.count else {
                    return
                }
                
                let restaurant = restaurants[rowClick]
                vc.nameRest=restaurant["name"] as! String
                vc.location=restaurant["place"] as! String
                vc.review=restaurant["review"] as! String
                
                vc.imgrest=Imgrest[rowClick]
                vc.TypeRest=typerest[rowClick]
                vc.OpenClose=openclose[rowClick]
                
                collec=imgPlist.restAll[rowClick]
                vc.collecView=imgPlist.ImgRest[collec]!
            }
        }
    }
}
