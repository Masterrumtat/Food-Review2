//
//  ImgPlist.swift
//  Food-Review2
//
//  Created by Jazzy on 1/12/2566 BE.
//

import UIKit

class ImgPlist: NSObject {
    var ImgRest:Dictionary = [String:[String]]()
    var restAll:Array = [String]()
    var imgAll:Array = [String]()
    
    func loadPlist(fname:String){
        let url = Bundle.main.url(forResource: fname, withExtension: "plist")!
        let testData = try! Data(contentsOf: url)
        let myPlist = try! PropertyListSerialization.propertyList(from: testData, options: [], format: nil)
        print(myPlist)
        ImgRest=myPlist as! Dictionary
        
//        for (k,v) in Array(ImgRest).sorted(by: {$0.0 < $1.0}){
//            restAll.append(k)
//            for s in v{
//                imgAll.append(s)
//            }
//        }
                for (k,v) in ImgRest{
                    restAll.append(k)
                    for s in v{
                        imgAll.append(s)
                    }
                }
    }
}
