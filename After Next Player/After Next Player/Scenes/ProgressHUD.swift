//
//  ProgressHUD.swift
//  ZAR
//
//  Created by mohamed hisham on 9/11/19.
//  Copyright © 2019 Robusta. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class ProgressHUD: UIVisualEffectView {

    var text: String? {
        didSet {
            label.text = text
        }
    }

    let activityIndictor: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .prominent)
    let vibrancyView: UIVisualEffectView

    init(text: String) {
            activityIndictor.loadGif(name: "ball")
                   activityIndictor.startAnimating()
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        label.numberOfLines = 0
        label.clipsToBounds = true
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if let superview = self.superview {
            
            let width = superview.frame.size.width / 1.5
            let height: CGFloat = 70
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds

            let activityIndicatorSize: CGFloat = 80
            activityIndictor.frame = CGRect(x: 5,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)

            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.font = UIFont(name: "Futura", size: 18)
        }
    }

    func show() {
        self.isHidden = false
    }

    func hide() {
        self.isHidden = true
    }
}
