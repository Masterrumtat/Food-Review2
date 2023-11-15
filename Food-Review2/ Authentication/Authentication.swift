//
//  Authentication.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//

import UIKit
import FirebaseAuth

class Authentication: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerLabel: UILabel! // Add this line to declare the label outlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the sign in button
        signInBtn.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        // Set initial text for the register label
        registerLabel.text = "" // Initially set the label text to empty
    }
    
    @objc func signInTapped() {
        // Get the user's email address and password
        let email = email.text!
        let password = password.text!
        
        // Sign in the user
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                // Handle the error
                registerLabel.text = "Please enter your email address or password to continue."
                print(error.localizedDescription)
            } else {
                // The user is verified, redirect to the next screen
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "page1")
                self.navigationController?.pushViewController(nextViewController!, animated: true)
            }
        }
    }
}