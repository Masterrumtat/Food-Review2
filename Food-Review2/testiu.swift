//
//  testiu.swift
//  Food-Review2
//
//  Created by Vituruch Sinthusate on 21/11/2566 BE.
//

import UIKit
import SwiftUI
class testiu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        }
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return  UIHostingController(coder: coder, rootView: SwiftUIView())
       
        struct SwiftUIView: View {
            var body: some View {
                ZStack {
                    Color.pink
                    Button("Hello, SwiftUI!") {
                        
                    }
                    .font(.title)
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .navigationTitle("SwiftUI View")
            }
        }
    }
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


