//
//  Register.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class Register: UIViewController {
    
        @IBOutlet weak var name: UITextField!
        @IBOutlet weak var email: UITextField!
        @IBOutlet weak var password: UITextField!
        @IBOutlet weak var registerBtn: UIButton!
    
        @IBAction func btnRegister(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set up the register button
            registerBtn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
            
            password.isSecureTextEntry = true
        }
        
        @objc func registerTapped() {
            // Get the user's name, email address, and password
            let name = name.text!
            let email = email.text!
            let password = password.text!
            
            // Create a new user account
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    // Handle the error
                    print(error.localizedDescription)
                } else {
                    // The user account was created successfully
                    // Save the user's name to the database
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(result!.user.uid)
                    
                    userRef.getDocument { snapshot, error in
                        if let error = error {
                            // Handle the error
                            print(error.localizedDescription)
                        } 
                        else {
                            // Get the user's name from the snapshot
                            let name = snapshot?["name"] as? String
                            
                            // Save the user's name to the database
                            userRef.updateData(["name": name as Any])
                        }
                    }
                }
            }
        }
    }

