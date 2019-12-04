//
//  ExpandableTableViewCell.swift
//  BlueBus
//
//  Created by Ahmed Osama on 7/21/19.
//  Copyright © 2019 BlueBus. All rights reserved.
//

import UIKit


protocol ExpandableTableViewCellDelegate: AnyObject {
    func toggleExpansion(cell: ExpandableTableViewCell)
    func cellButtonDidTap(cell: ExpandableTableViewCell)
}

class ExpandableTableViewCell: UITableViewCell {

    weak var delegate: ExpandableTableViewCellDelegate?
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    @IBOutlet weak var cellTextBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellButtonBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    func setupViews() {
        setupUpperView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(upperViewDidTap))
        upperView.addGestureRecognizer(tapGesture)
    }
    
    @objc func upperViewDidTap() {
        delegate?.toggleExpansion(cell: self)
    }
    
    func setupUpperView() {
        upperView.layer.cornerRadius = 10
        upperView.layer.borderWidth = 0.9
        upperView.layer.borderColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha:1).cgColor
    }
    
    func setTitleLabelText(_ text: String) {
        var fontName = ""
        let fontSize: CGFloat = 16
        var alignment: NSTextAlignment
       
    }
    
    func setCellDescriptionLabelText(_ text: String) {
        var fontName = ""
        let fontSize: CGFloat = 16
        var alignment: NSTextAlignment
      
        }
        
      
    
    
    func setButtonTitle(_ text: String?) {
        guard let text = text else {
            setButtonHidden(true)
            return
        }
        setButtonHidden(false)
        var fontName = ""
        let fontSize: CGFloat = 16
        
        }
        
       
    
 
    func setButtonHidden(_ hidden: Bool) {
        cellButtonHeightConstraint.constant = hidden ? 0 : 44
        cellButtonBottomConstraint.constant = hidden ? 0 : 20
    }
    
    @IBAction func cellButtonDidTap(_ sender: Any) {
        delegate?.cellButtonDidTap(cell: self)
    }
    
}
