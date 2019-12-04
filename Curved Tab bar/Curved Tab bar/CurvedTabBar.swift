//
//  CurvedTabBar.swift
//  Curved Tab bar
//
//  Created by mohamed hisham on 7/22/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class CurvedTabBar: UITabBar {

    private var shapeLayer: CALayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
      
        shapeLayer.fillColor = #colorLiteral(red: 0.2196078431, green: 0.09803921569, blue: 0.3098039216, alpha: 1)
  
        shapeLayer.shadowOffset = CGSize(width:0, height:-5)
        shapeLayer.shadowRadius = 2
        shapeLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shapeLayer.shadowOpacity = 0.1
        shapeLayer.shadowRadius = 5
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
//        self.backgroundColor = .clear
        self.addShape()
        setupMiddleButton()
    }
    
    func createPath() -> CGPath {
        
        let path = UIBezierPath()
        let height: CGFloat = 48
        let centerWidth = self.frame.width / 2
     
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    func setupMiddleButton() {
        
        let middleBtn = UIButton(frame: CGRect(x: (self.bounds.width / 2)-28.5, y: -15, width: 47, height: 47))
        middleBtn.layer.cornerRadius = 0.5 * middleBtn.bounds.size.width
        middleBtn.setImage(UIImage(named: "add.png"), for:.normal)
        middleBtn.backgroundColor = #colorLiteral(red: 0.8117647059, green: 0.6980392157, blue: 0.7725490196, alpha: 1)
        self.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.layoutIfNeeded()
    }
    
    
    @objc func menuButtonAction(sender: UIButton) {
        print("touched")
    }
}
extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
