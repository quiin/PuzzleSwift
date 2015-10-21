//
//  Login.swift
//  Puzzle
//
//  Created by Carlos Alejandro Reyna González on 19/10/15.
//  Copyright (c) 2015 itesm. All rights reserved.
//

import UIKit

class Login: UIViewController {

    
    var loginChecker: [Int] = [Int](count: 3, repeatedValue: -1)
    
    //Outlets
    @IBOutlet weak var lbl_santa: UILabel!
    
    //Long press gesture
    @IBAction func onLongPress(sender: AnyObject) {
        if  (loginChecker[0] == -1 || loginChecker[0] == 1) &&
            loginChecker[1] == -1 &&
            loginChecker[2] == -1 {
                
                loginChecker[0] = 1
                feedback(true)
            
        }else{
            feedback(false)
        }

        
    }
    
    @IBAction func onLeftSwipe(sender: UISwipeGestureRecognizer) {
        if loginChecker[0] == 1{
            loginChecker[1] = 2
        }else{
            feedback(false)
            loginChecker = [Int](count: 3, repeatedValue: -1)
        }
        
    }
  
    
    @IBAction func onDownSwipe(sender: AnyObject) {
        if loginChecker[1] == 2{
            loginChecker[2] = 3
            
            performSegueWithIdentifier("toPuzzle", sender: self)
           
        }else{
            feedback(false)
            loginChecker = [Int](count: 3, repeatedValue: -1)
        }
        
    }

    
 
    
    func feedback(flag:Bool){
        if flag{
            self.view.backgroundColor = UIColor.greenColor()
        }else{
            self.view.backgroundColor = UIColor.redColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginChecker = [Int](count: 3, repeatedValue: -1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

