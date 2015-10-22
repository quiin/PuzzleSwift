//
//  Login.swift
//  Puzzle
//
//  Created by Carlos Alejandro Reyna González on 19/10/15.
//  Copyright (c) 2015 itesm. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import MediaPlayer

class Puzzle: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIGestureRecognizerDelegate {
    
    //vars & cons
    var pieces = ["puzzle_01.gif", "puzzle_02.gif", "puzzle_03.gif", "puzzle_04.gif", "puzzle_05.gif", "puzzle_06.gif", "puzzle_07.gif", "puzzle_08.gif", "puzzle_09.gif"]
    var winning = ["puzzle_01.gif", "puzzle_02.gif", "puzzle_03.gif", "puzzle_04.gif", "puzzle_05.gif", "puzzle_06.gif", "puzzle_07.gif", "puzzle_08.gif", "puzzle_09.gif"]

    var fromCell = UICollectionViewCell()
    var fromIndex = -1
    var toIndex = -1
    var timer : NSTimer = NSTimer()
    let cellID = "piece"
    var screenSize:CGRect!
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var currentTime = 0
    var bestTime = -1

    
    //Outlets
    @IBOutlet weak var lbl_timeLeft: UILabel!
    @IBOutlet weak var lbl_bestTime: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btn_reset: UIButton!
    
    
    //Collection methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
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
        cell.frame.size.width = screenWidth/4
        cell.frame.size.height = screenHeight/4
        let piece:UIImageView = cell.viewWithTag(100) as! UIImageView
        piece.image = UIImage(named: pieces[indexPath.row])
        piece.image?.accessibilityIdentifier = pieces[indexPath.row]
        return cell
    }
    

    
    //handeLongPress
    func onLongPress(gestureRecognicer: UIPanGestureRecognizer){
        
        var point:CGPoint = gestureRecognicer.locationInView(self.collectionView)
        var center = CGPointZero
        
        switch gestureRecognicer.state {
        case .Began:
            let indexPath = self.collectionView.indexPathForItemAtPoint(point)
            if let index = indexPath{
                self.fromCell = self.collectionView.cellForItemAtIndexPath(indexPath!)!
                fromIndex = index.row
                let piece:UIImageView = fromCell.viewWithTag(100) as! UIImageView

            }
        case .Changed:
            let indexPath = self.collectionView.indexPathForItemAtPoint(point)
            if let index = indexPath{
                let piece:UIImageView = fromCell.viewWithTag(100) as! UIImageView
                center = piece.center
                //validate this
                self.fromCell.center.x = point.x
                self.fromCell.center.y = point.y
            }
            
        case .Ended:
            let indexPath = self.collectionView.indexPathForItemAtPoint(point)
            if let index = indexPath{

                toIndex = index.row
                
                let fromName = pieces[fromIndex]
                let toName = pieces[toIndex]
                let tempName = fromName

                pieces[fromIndex] = toName
                pieces[toIndex] = tempName
                
                let URL = NSBundle.mainBundle().URLForResource("clic", withExtension: "wav")
                var soundID:SystemSoundID = 0
                AudioServicesCreateSystemSoundID(URL, &soundID)
                AudioServicesPlayAlertSound(soundID)
                
                
                if didWin(){
                    btn_reset.enabled = true
                    var alert = UIAlertController(title: "Congratz!", message: "You won GG 👏🏼🎉", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    timer.invalidate()
                    println(bestTime)
                    println(currentTime)
                    
                    if currentTime < bestTime{
                        var txt = "Best time: "
                        txt += String(currentTime)
                        lbl_bestTime.text = txt
                    }
                    if bestTime < 0{
                        bestTime = currentTime
                        lbl_bestTime.text = String(bestTime)
                    }
                    
                }
                
            }
            collectionView.reloadData()
            collectionView.reloadInputViews()
            
        default:
            println("Default??????")
        }
       
    }
    
    
    
   
    @IBAction func reset(sender: AnyObject) {
        shuffle()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        currentTime = 0
        lbl_timeLeft.text = String(currentTime)
        collectionView.reloadData()
        btn_reset.enabled = false
    }
   
    
    
    func didWin() -> Bool{
        println(pieces)
        for i in 0..<pieces.count{
            if pieces[i] != winning[i]{
                return false
            }
        }
        
        return true
    }
    
    func shuffle(){
        for i in 0..<pieces.count{
            var j = Int(arc4random_uniform(UInt32(pieces.count)))
            let temp = pieces[i]
            pieces[i] = pieces[j]
            pieces[j] = temp
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        btn_reset.enabled = false
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0)
        layout.itemSize = CGSize(width: screenWidth/4,height: screenHeight/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        let longPress = UIPanGestureRecognizer(target: self, action: "onLongPress:")
        longPress.minimumNumberOfTouches = 1
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        self.collectionView.addGestureRecognizer(longPress)
        
        
        
        
        shuffle()

    }
    
    func update(){
        currentTime++
        lbl_timeLeft.text = String(currentTime)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}