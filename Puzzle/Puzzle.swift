//
//  Login.swift
//  Puzzle
//
//  Created by Carlos Alejandro Reyna González on 19/10/15.
//  Copyright (c) 2015 itesm. All rights reserved.
//

import UIKit

class Puzzle: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    
    //vars & cons
    var pieces = ["puzzle_01.gif", "puzzle_02.gif", "puzzle_03.gif", "puzzle_04.gif", "puzzle_05.gif", "puzzle_06.gif", "puzzle_07.gif", "puzzle_08.gif", "puzzle_09.gif", "puzzle_10.gif", "puzzle_11.gif", "puzzle_12.gif", "puzzle_13.gif", "puzzle_14.gif", "puzzle_15.gif", "puzzle_16.gif"]
    
    var fromCell = UICollectionViewCell()
    var toCell = UICollectionViewCell()
    
    
    var timer : NSTimer = NSTimer()
    let cellID = "piece"
    
    //Outlets
    @IBOutlet weak var lbl_timeLeft: UILabel!
    @IBOutlet weak var lbl_bestTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Collection methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    //fill collectionView
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! UICollectionViewCell
        let piece:UIImageView = cell.viewWithTag(100) as! UIImageView
        piece.image = UIImage(named: pieces[indexPath.row])
        piece.image?.accessibilityIdentifier = pieces[indexPath.row]
        return cell
    }
    
    
    //handeLongPress
    func onLongPress(gestureRecognicer: UIPanGestureRecognizer){
        var firstSelected = -1
        var lastSelected = -1
        
        var point:CGPoint = gestureRecognicer.locationInView(self.collectionView)
        var center = CGPointZero
        
        switch gestureRecognicer.state {
        case .Began:
            println("Began")
            let indexPath = self.collectionView.indexPathForItemAtPoint(point)
            if let index = indexPath{
                self.fromCell = self.collectionView.cellForItemAtIndexPath(indexPath!)!
                firstSelected = index.row
                println("First selected = \(firstSelected)")
                let piece:UIImageView = fromCell.viewWithTag(100) as! UIImageView
                println(piece.image?.accessibilityIdentifier)
            }
        case .Changed:
            let indexPath = self.collectionView.indexPathForItemAtPoint(point)
            if let index = indexPath{

                let piece:UIImageView = fromCell.viewWithTag(100) as! UIImageView
                center = piece.center
                self.fromCell.center.x = point.x
                self.fromCell.center.y = point.y
            }
            
        case .Ended:
            println("Ended")
            collectionView.reloadData()
            
        default:
            println("Default??????")
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UIPanGestureRecognizer(target: self, action: "onLongPress:")
        longPress.minimumNumberOfTouches = 1
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}