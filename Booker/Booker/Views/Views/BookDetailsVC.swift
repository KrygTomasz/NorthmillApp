//
//  BookDetailsVC.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class BookDetailsVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = GlobalValues.MEDIUM_CORNER_RADIUS
        }
    }
    
    @IBOutlet weak var imageContentView: UIView! {
        didSet {
            imageContentView.isHidden = true
        }
    }
    @IBOutlet weak var titleContentView: UIView!
    @IBOutlet weak var separatorContentView: UIView!
    @IBOutlet weak var descriptionContentView: UIView! {
        didSet {
            //descriptionContentView.isHidden = true
        }
    }
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = UIColor.backgroundColor
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var bookVM: BookVM? {
        didSet {
            titleLabel.text = bookVM?.title
            descriptionLabel.text = bookVM?.description
            bookVM?.downloadImage(completion: setCoverImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationBar(withTitle: "details".localized())
        self.view.backgroundColor = UIColor.backgroundColor
    }
    
    private func setCoverImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            var hideImage = false
            if let image = image {
                self?.coverImage.image = image
                hideImage = false
            } else {
                hideImage = true
            }
            self?.imageContentView.isHidden = hideImage
        }
    }
    
}

//MARK: Constructor
extension BookDetailsVC {
    
    static func getInstance(using vm: BookVM?) -> BookDetailsVC {
        let vc = BookDetailsVC(nibName: "BookDetailsVC", bundle: nil)
        let _ = vc.view
        vc.bookVM = vm
        return vc
    }
    
}
