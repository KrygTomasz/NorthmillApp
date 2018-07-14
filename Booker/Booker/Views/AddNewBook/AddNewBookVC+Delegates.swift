//
//  AddNewBookVC+Delegates.swift
//  Booker
//
//  Created by Kryg Tomasz on 13.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: Delegate definitions
protocol AddNewBookVCDelegate: class {
    func showIndicator()
    func hideIndicator(success: Bool)
    func hideVC(withReload reload: Bool)
    func showSuccessfulAddBookAlert()
}

//MARK: UIGestureRecognizerDelegate
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

//MARK: AddNewBookVCDelegate
extension AddNewBookVC: AddNewBookVCDelegate {
    func showIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.view.isUserInteractionEnabled = false
            self?.addBookButton.isHidden = true
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
        }
    }
    func hideIndicator(success: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.view.isUserInteractionEnabled = true
            self?.addBookButton.isHidden = false
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
    func hideVC(withReload reload: Bool) {
        if reload {
            presentingViewDelegate?.reloadBookData()
        }
        dismissVC()
    }
    func showSuccessfulAddBookAlert() {
        presentingViewDelegate?.showSuccessfulAddBookAlert()
    }
}

//MARK: UITextField and UITextView delegates
extension AddNewBookVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddNewBookVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
