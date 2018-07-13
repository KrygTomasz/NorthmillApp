//
//  AddNewBookVC.swift
//  Booker
//
//  Created by Kryg Tomasz on 13.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class AddNewBookVC: UIViewController {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = GlobalValues.BIG_CORNER_RADIUS
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "bookTitle".localized() + ":"
        }
    }
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleUnderlineView: UIView! {
        didSet {
            titleUnderlineView.backgroundColor = UIColor.backgroundColor
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "bookDescription".localized() + ":"
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.layer.borderColor = UIColor.backgroundColor.cgColor
            descriptionTextView.layer.borderWidth = 1.0
            descriptionTextView.layer.cornerRadius = GlobalValues.MEDIUM_CORNER_RADIUS
        }
    }
    @IBOutlet weak var urlLabel: UILabel! {
        didSet {
            urlLabel.text = "coverUrlLink".localized() + ":"
        }
    }
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var urlUnderlineView: UIView! {
        didSet {
            urlUnderlineView.backgroundColor = UIColor.backgroundColor
        }
    }
    @IBOutlet weak var addBookButton: UIButton! {
        didSet {
            addBookButton.setTitle("addBook".localized(), for: .normal)
            addBookButton.backgroundColor = UIColor.backgroundColor
            addBookButton.setTitleColor(UIColor.white, for: .normal)
            addBookButton.layer.cornerRadius = GlobalValues.MEDIUM_CORNER_RADIUS
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        prepareContent()
    }
    private func prepareContent() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addDismissTapGesture()
    }
    private func addDismissTapGesture() {
        self.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissVC() {
        self.dismiss(animated: false, completion: nil)
    }

}

//MARK: Constructor
extension AddNewBookVC {
    
    static func getInstance() -> AddNewBookVC {
        let vc = AddNewBookVC(nibName: "AddNewBookVC", bundle: nil)
        let _ = vc.view
        return vc
    }
    
}

//MARK: Delegates
extension AddNewBookVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if
            let touchedView = touch.view,
            touchedView == self.view {
            return true
        }
        return false
    }
}
