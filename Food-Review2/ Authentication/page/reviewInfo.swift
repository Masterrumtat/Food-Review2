//
//  reviewInfo.swift
//  Food-Review2
//
//  Created by Jazzy on 1/12/2566 BE.
//

import UIKit

class reviewInfo: UIViewController {
    
    var nameRest:String=""
    var location:String=""
    var imgrest:String=""
    var review:String=""

    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var lbRest: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var txtReview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbRest.text=nameRest
        lbLocation.text=location
        txtReview.text=review
        imgRest.image=UIImage.init(named: imgrest)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
