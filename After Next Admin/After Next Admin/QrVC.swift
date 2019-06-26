//
//  QrVC.swift
//  After Next Admin
//
//  Created by hassan elshaer on 6/26/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class QrVC: UIViewController {
    @IBOutlet weak var qrImage: UIImageView!
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        qrImage.image = image
    }
    @IBAction func ScreenShot(_ sender: Any) {
        screenShot()
    }
    func screenShot() {
        let layer = UIApplication.shared.keyWindow?.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions((layer?.frame.size)!, false, scale)
        layer?.render(in: UIGraphicsGetCurrentContext()!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenShot!, nil, nil, nil)
    }
}
