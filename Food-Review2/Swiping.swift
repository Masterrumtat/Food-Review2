//
//  ViewController.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//

import UIKit

class Swiping: UIViewController {
    
   
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    
        private var restaurants: [[String: String]] = []
        private var currentProfileIndex: Int = 0

    override func viewDidLoad() {
           super.viewDidLoad()
           imgPlist()
           showProfile()

           // Add a pan gesture recognizer to the cardImageView
           let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
           cardImageView.addGestureRecognizer(panGestureRecognizer)
       }

       func imgPlist() {
           if let path = Bundle.main.path(forResource: "restimg", ofType: "plist"),
               let array = NSArray(contentsOfFile: path) as? [[String: String]] {
               restaurants = array
           }
       }

       func showProfile() {
           guard currentProfileIndex < restaurants.count else {
               // Handle end of profiles
               return
           }

           let profile = restaurants[currentProfileIndex]

           if let imageName = profile["image"], let image = UIImage(named: imageName) {
               cardImageView.image = image
           } else {
               print("Image not found for profile: \(profile)")
           }
       }

       @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
           let translation = sender.translation(in: cardImageView)

           // Move the cardImageView according to the user's swipe gesture
           cardImageView.center = CGPoint(x: cardImageView.center.x + translation.x, y: cardImageView.center.y + translation.y)
           sender.setTranslation(CGPoint.zero, in: cardImageView)

           if sender.state == .ended {
               handleSwipeEnd()
           }
       }

       private func handleSwipeEnd() {
           let swipeThreshold: CGFloat = 120.0

           if cardImageView.center.x < (view.center.x - swipeThreshold) {
               // Swiped left (dislike)
               currentProfileIndex += 1
               print("pass")
           } else if cardImageView.center.x > (view.center.x + swipeThreshold) {
               // Swiped right (like)
               currentProfileIndex += 1
               print("pass2")
               // You can add additional logic for handling a "like" here
           }

           // Reset cardImageView position
           UIView.animate(withDuration: 0.3) {
               self.cardImageView.center = self.view.center
           }

           // Show the next profile
           showProfile()
       }

       // Handle like and dislike actions, and update the current profile index
       // ...
   }
