//
//  reviewInfo.swift
//  Food-Review2
//
//  Created by Jazzy on 1/12/2566 BE.
//

import UIKit

class reviewInfo: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var nameRest:String=""
    var location:String=""
    var imgrest:String=""
    var review:String=""
    
    var collecView:[String]=[]
    var imgPlist=ImgPlist()
    
    var TypeRest:String=""
    var OpenClose:String=""

    @IBOutlet weak var imgRest: UIImageView!
    @IBOutlet weak var lbRest: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var txtReview: UITextView!
    
    @IBOutlet weak var collectView: UICollectionView!
    
    @IBOutlet weak var typeRest: UILabel!
    @IBOutlet weak var openClose: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbRest.text=nameRest
        lbLocation.text=location
        txtReview.text=review
        imgRest.image=UIImage.init(named: imgrest)
        typeRest.text=TypeRest
        openClose.text=OpenClose
        
        imgPlist.loadPlist(fname: "ImgRest")

        // Do any additional setup after loading the view.
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 250, height: 200)
                flowLayout.minimumLineSpacing = 10
                flowLayout.minimumInteritemSpacing = 10
                flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        flowLayout.scrollDirection = .horizontal
        
        collectView.collectionViewLayout = flowLayout
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collecView.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "data", for: indexPath) as! CollectionViewCell
        cell.imgView.image=UIImage.init(named: collecView[indexPath.row])

        return cell
    }

}
