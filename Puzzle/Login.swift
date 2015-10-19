//
//  Login.swift
//  Puzzle
//
//  Created by Carlos Alejandro Reyna González on 19/10/15.
//  Copyright (c) 2015 itesm. All rights reserved.
//

import UIKit

class Login: UIViewController {

    
    //Outlets
    @IBOutlet weak var santa: UILabel!
    @IBOutlet weak var princess: UILabel!
    @IBOutlet weak var allahuAkbar: UILabel!
    @IBOutlet weak var bride: UILabel!
    

   
    @IBAction func onLongPress(sender: UIPanGestureRecognizer) {
        let touchPos = sender.locationInView(self.view)
        let santaPos = santa.frame
        println("touch \(touchPos)")
        println("santa \(santaPos)")
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

