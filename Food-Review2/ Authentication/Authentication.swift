//
//  Authentication.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


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
        
        password.isSecureTextEntry = true
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
                    // Update the register label text
                    registerLabel.text = "The email address or password is incorrect. Please retry"
                    let nextViewControllerID = "Review"
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: nextViewControllerID) as! UITableViewController
                    self.present(nextViewController, animated: true, completion: nil)
                    print("log")// Update the label text to "ลงทะเบียนสำเร็จ"
                }
            }
        }
    
    }
