//
//  HomeXTableViewController.swift
//  BanglaNews24
//
//  Created by Babul Mirdha on 2/2/15.
//  Copyright (c) 2015 Suptalo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var currentIndex = 0
    
    
   var imageUrls = ["a.jpg" , "b.jpg" ,"c.jpg" ,"d.jpg","e.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         var pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchDetected:")
         self.view.addGestureRecognizer(pinchRecognizer)
        addGesturetoImageView();
        
     //   self.pageControl.numberOfPages =  self.imageUrls.count ?? 0
        
    //    self.pageControl.currentPage = 0;
        changeImage(0);
       
    }
    
    
    
    func addGesturetoImageView()  {
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.imageView.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.imageView.addGestureRecognizer(swipeLeft)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                
                if(currentIndex > 0) {
                    currentIndex--
                    showAminationOnAdvert(kCATransitionFromLeft);
                    self.navigationItem.title = " \(currentIndex)  /  \(imageUrls.count - 1) "
                }

                changeImage(currentIndex);
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped Left")
                
                
                if(currentIndex < self.imageUrls.count-1) {
                    
                    currentIndex++
                   // self.pageControl.currentPage = currentIndex;
                    showAminationOnAdvert(kCATransitionFromRight);
                    println(" \(currentIndex)  /  \(imageUrls.count - 1) ")
                    self.navigationItem.title = " \(currentIndex)  /  \(imageUrls.count - 1) "
                    
                }
                
                changeImage(currentIndex);
                
            default:
                break
            }
        }
    }
    
    
    
    
    func showAminationOnAdvert(subtype :String){
        var  transitionAnimation = CATransition();
        transitionAnimation.type = kCATransitionPush;
        transitionAnimation.subtype = subtype;
        
        transitionAnimation.duration = 0.5;
        
        
        transitionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        transitionAnimation.fillMode = kCAFillModeBoth;
        
        imageView.layer.addAnimation(transitionAnimation, forKey: "fadeAnimation")
        
    }

    func changeImage(index:Int){
        var imageName = self.imageUrls[index];
        
        self.imageView.image = UIImage(named: imageName)
     

    }
    
    
    @IBAction func changeAdvert(sender: AnyObject) {
        //println("value change")
     //   println("change image \(self.pageControl.currentPage)");
        
        
        if(self.currentIndex > 0)
        {
            changeImage(currentIndex);
            showAminationOnAdvert(kCATransitionFromRight)
        }else if self.currentIndex < self.imageUrls.count {
            changeImage(currentIndex);
            showAminationOnAdvert(kCATransitionFromLeft)
        }
        
     //   self.currentIndex = self.pageControl.currentPage
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    func pinchDetected(pinchRecognizer: UIPinchGestureRecognizer) {
        var h = self.view.frame.size.height;
        var w = self.view.frame.size.width;
        var scale: CGFloat = pinchRecognizer.scale;
        if w * scale >= screenSize.width && h * scale >= screenSize.height
        {
            
            self.view.transform = CGAffineTransformScale(self.view.transform, scale, scale);
            pinchRecognizer.scale = 1.0;
        }
        
        //  println(w)
        // println(h)
        
    }

}
