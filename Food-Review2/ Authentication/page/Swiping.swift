//
//  ViewController.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 14/11/2566 BE.
//



import UIKit


class Swiping: UIViewController {
    
    @IBAction func btnCheck(_ sender: Any) {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = storyBoard.instantiateViewController(identifier: "MainNC") as! NC
        self.view.window?.rootViewController = mvc
    }
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    private var images: [String] = []  // Assume you have an array of image names
    
    private var currentImageIndex: Int = 0
    private var initialPanPoint: CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImagesFromPlist()
        showImage()
        
        // Add a pan gesture recognizer to the cardImageView
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        cardImageView.isUserInteractionEnabled = true
        cardImageView.addGestureRecognizer(panGestureRecognizer)
        // Add a pan gesture recognizer to the cardImageView
    }
   

    func loadImagesFromPlist() {
        if let path = Bundle.main.path(forResource: "nameRestimg", ofType: "plist"),
           let array = NSArray(contentsOfFile: path) as? [String] {
            images = array
            print("Loaded \(images.count) images from plist.")
        } else {
            print("Failed to load images from plist.")
        }
    }
    
    func showImage() {
        guard currentImageIndex < images.count else {
            print("End of images")
            return
        }
        
        let imageName = images[currentImageIndex]
        
        if let image = UIImage(named: imageName) {
            cardImageView.image = image
            print("Showing image: \(imageName)")
        } else {
            print("Image not found: \(imageName)")
        }
    }
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialPanPoint = sender.translation(in: cardImageView)
        case .changed:
            let translation = sender.translation(in: cardImageView)
            cardImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            let translation = sender.translation(in: cardImageView)
            
            if translation.x > 100 {
                swipeRight()
            } else if translation.x < -100 {
                swipeLeft()
            } else {
                resetCardPosition()
            }
            
            initialPanPoint = CGPoint()
        default:
            break
        }
    }
    private func animateCardRemoval() {
        UIView.animate(withDuration: 0.3, animations: {
            self.cardImageView.alpha = 0.0
        }) { _ in
            self.resetCardPosition()
            self.cardImageView.alpha = 1.0

            self.performSegue(withIdentifier: "swipeInfo", sender: nil)
        }
    }
    
    private func swipeRight() {
        print("Swiped right")
        goToNextImage()
        resetCardPosition()
    }
    
    private func swipeLeft() {
        print("Swiped left")
        
        goToNextImage()
        resetCardPosition()
    }
    
    private func resetCardPosition() {
        UIView.animate(withDuration: 0.3) {
            self.cardImageView.transform = .identity
        }
    }
    
    private func goToNextImage() {
        currentImageIndex += 1
        
        if currentImageIndex < images.count {
            showImage()
        } else {
            print("End of images")
        }
    }
}
