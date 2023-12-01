

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
    
    var restaurants: [DocumentSnapshot] = []
    var Imgrest: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=300
        
        // Call a function to fetch data from Firestore
        fetchDataFromFirestore()
        imgRest()
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
           guard let link = Bundle.main.url(forResource: "restimg", withExtension: "plist"),
                 let testData = try? Data(contentsOf: link),
                 let imgRestArray = try? PropertyListSerialization.propertyList(from: testData, options: [], format: nil) as? [String] else {
               print("Failed to load image names from plist.")
               return
           }
           
           Imgrest = imgRestArray
           print(Imgrest)
       }
   }
    
