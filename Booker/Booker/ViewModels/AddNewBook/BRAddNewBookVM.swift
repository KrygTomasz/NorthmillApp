//
//  BRAddNewBookVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 13.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

//MARK: AddNewBookVM implementation
class BRAddNewBookVM: AddNewBookVM {
    
    //MARK: Initializer
    init(with delegate: AddNewBookVCDelegate) {
        self.viewDelegate = delegate
        self.title = ""
        self.description = ""
        self.imageUrl = ""
    }
    
    //MARK: Variables
    var title: String
    var description: String
    var imageUrl: String
    weak var viewDelegate: AddNewBookVCDelegate?
    
    //MARK: Methods
    func tryToAdd() -> AddBookStatus {
        if title.isEmpty {
            return .noTitle
        }
        if description.isEmpty {
            return .noDescription
        }
        viewDelegate?.showIndicator()
        let book = BRBook(id: "", title: self.title, description: self.description, coverUrl: self.imageUrl)
        RequestManager.shared.addBook(book) { [weak self]
            success in
            self?.viewDelegate?.hideIndicator(success: success)
            if success {
                self?.viewDelegate?.hideVC(withReload: true)
                self?.viewDelegate?.showSuccessfulAddBookAlert()
            }
            return
        }
        return .successful
    }
    
}
