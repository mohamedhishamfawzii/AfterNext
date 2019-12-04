//
//  ViewController.swift
//  Faomi
//
//  Created by mohamed hisham on 7/21/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hishamToTop: NSLayoutConstraint!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var blackToTop: NSLayoutConstraint!
    @IBOutlet weak var yellowToTop: NSLayoutConstraint!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var cellToLeft: NSLayoutConstraint!
    var start = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        yellowView.layer.cornerRadius=35
        cellImage.layer.cornerRadius=15
        blackView.layer.cornerRadius=35
     //   self.setStatusBarBackgroundColor(color: #colorLiteral(red: 0.02352941176, green: 0.01960784314, blue: 0.09019607843, alpha: 1))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUpFirst))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownFirst))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeUpFirst(sender:AnyObject?){
        self.start=false
     yellowToTop.constant=0
        blackToTop.constant=150
        cellToLeft.constant = -220
        cellImage.alpha=0.7
    hishamToTop.constant += 150
        
        UIView.animate(
            
            withDuration: 0.5,
            
            delay: 0.0,options: .curveLinear,
            animations:{ [weak self] in
                self?.view.layoutIfNeeded()
                
                
        }, completion: {finished in
           // self.setStatusBarBackgroundColor(color: #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.6431372549, alpha: 1))
            self.yellowView.layer.cornerRadius=0
            self.hishamToTop.constant -= 150
            UIView.animate(
                
                withDuration: 0.5,
                
                delay: 0.0,options: .showHideTransitionViews,
                animations:{ [weak self] in
                    self?.view.layoutIfNeeded()
                    
                    
                })
       
        }
        )
        
    }
    
    @objc func swipeDownFirst(sender:AnyObject?){
        if (start){
            blackToTop.constant=600
            UIView.animate(
                
                withDuration: 0.8,
                
                delay: 0.0,
                animations: {[weak self] in
                    self?.view.layoutIfNeeded()})
                    
            }
        else{
        yellowToTop.constant=200
        blackToTop.constant=300
        cellToLeft.constant = 30
            
        //  self.setStatusBarBackgroundColor(color: #colorLiteral(red: 0.02352941176, green: 0.01960784314, blue: 0.09019607843, alpha: 1))
           self.yellowView.layer.cornerRadius=35
        UIView.animate(
            
            withDuration: 0.8,
            
            delay: 0.0,
            animations: {[weak self] in
                self?.view.layoutIfNeeded()
                
                
        }, completion: {finished in
            
           self.start=true
            self.cellImage.alpha=1
         
        }
            )}
        
    }
//    func setStatusBarBackgroundColor(color: UIColor) {
//
//        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
//
//        statusBar.backgroundColor = color
//    }
    


}

