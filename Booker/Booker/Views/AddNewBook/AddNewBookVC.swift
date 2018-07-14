//
//  AddNewBookVC.swift
//  Booker
//
//  Created by Kryg Tomasz on 13.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class AddNewBookVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = GlobalValues.BIG_CORNER_RADIUS
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = LABEL_COLOR
            titleLabel.text = "bookTitle".localized() + ":"
        }
    }
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            titleTextField.delegate = self
        }
    }
    @IBOutlet weak var titleUnderlineView: UIView! {
        didSet {
            titleUnderlineView.backgroundColor = UIColor.backgroundColor
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = LABEL_COLOR
            descriptionLabel.text = "bookDescription".localized() + ":"
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.delegate = self
            descriptionTextView.layer.borderColor = UIColor.backgroundColor.cgColor
            descriptionTextView.layer.borderWidth = 1.0
            descriptionTextView.layer.cornerRadius = GlobalValues.MEDIUM_CORNER_RADIUS
        }
    }
    @IBOutlet weak var urlLabel: UILabel! {
        didSet {
            urlLabel.textColor = LABEL_COLOR
            urlLabel.text = "coverUrlLink".localized() + ":"
        }
    }
    @IBOutlet weak var urlTextField: UITextField! {
        didSet {
            urlTextField.delegate = self
        }
    }
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
            addBookButton.addTarget(self, action: #selector(onAddBookClicked), for: .touchUpInside)
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
            activityIndicator.color = UIColor.backgroundColor
        }
    }
    
    //MARK: Variables
    let LABEL_COLOR: UIColor = .backgroundColor
    var addNewBookVM: AddNewBookVM?
    weak var presentingViewDelegate: BooksVCDelegate?
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewBookVM = BRAddNewBookVM(with: self)
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
    
    //MARK: Selector methods
    @objc func dismissVC() {
        self.dismiss(animated: false, completion: nil)
    }
    @objc func onAddBookClicked() {
        addNewBookVM?.title = titleTextField.text ?? ""
        addNewBookVM?.description = descriptionTextView.text
        addNewBookVM?.imageUrl = urlTextField.text ?? ""
        let addBookStatus = addNewBookVM?.tryToAdd()
        switch addBookStatus {
        case .noTitle?:
            titleLabel.textColor = .red
            descriptionLabel.textColor = LABEL_COLOR
            titleTextField.becomeFirstResponder()
        case .noDescription?:
            titleLabel.textColor = LABEL_COLOR
            descriptionLabel.textColor = .red
            descriptionTextView.becomeFirstResponder()
        case .successful?:
            return
        default:
            return
        }
    }

}

//MARK: Constructor
extension AddNewBookVC {
    static func getInstance(using presentingViewDelegate: BooksVCDelegate? = nil) -> AddNewBookVC {
        let vc = AddNewBookVC(nibName: "AddNewBookVC", bundle: nil)
        let _ = vc.view
        vc.presentingViewDelegate = presentingViewDelegate
        return vc
    }
}
