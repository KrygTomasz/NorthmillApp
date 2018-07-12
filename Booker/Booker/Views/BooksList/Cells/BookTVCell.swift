//
//  BookTVCell.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class BookTVCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = GlobalValues.MEDIUM_CORNER_RADIUS
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    var bookVM: BookVM? {
        didSet {
            titleLabel.text = bookVM?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func prepare(using vm: BookVM?) {
        self.bookVM = vm
    }
    
}
