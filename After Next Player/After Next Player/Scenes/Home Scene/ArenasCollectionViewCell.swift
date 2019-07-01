//
//  ArenasCollectionViewCell.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Cosmos

protocol ArenaBookedProtocol {
    func arenaBooked(index:Int , time:Int)
}
class ArenasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingStarsView: CosmosView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var selectedTime=0
    let times = ["6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","12 AM","1 AM"]
    var index:IndexPath?
    var delegate:ArenaBookedProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    func config(){
      //  ratingStarsView.rating = 0
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        priceLabel.layer.cornerRadius=2
        bookButton.layer.cornerRadius=2
        timePicker.layer.cornerRadius=2
        cellView.layer.cornerRadius=5
        cellView.layer.shadowRadius = 0.3
        cellView.layer.shadowColor=UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = CGSize(width: 1, height: 3)
        //cellView.layer.borderColor=UIColor.gray.cgColor
        cellView.layer.borderWidth=0.05
    }

    
    
    @IBAction func bookPressed(_ sender: Any) {
        print(self.delegate)
        delegate?.arenaBooked(index: index!.row, time: selectedTime )
    }
    
    
}
extension ArenasCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return 8
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    return times[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print (row)
        selectedTime=row
    }
    
    
}



