//
//  TabbarCell.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import UIKit

class TabbarCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    func configureCell(title: String, selected: Bool) {
        titleLbl.text = title
        separatorView.isHidden = !selected
    }
    
}
