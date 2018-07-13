//
//  BRBooksListVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

//MARK: BooksListVM implementation
class BRBooksListVM: BooksListVM {
    
    //MARK: Initializer
    init(with delegate: BooksVCDelegate) {
        self.viewDelegate = delegate
        numberOfSections = 1
    }
    
    //MARK: Variables
    var numberOfSections: Int
    var booksVMs: [BookVM] = []
    weak var viewDelegate: BooksVCDelegate?
    
    //MARK: Methods
    func numberOfRows(in section: Int) -> Int {
        return booksVMs.count
    }
    func getBookVM(for indexPath: IndexPath) -> BookVM? {
        if indexPath.section == 0 {
            let row = indexPath.row
            return booksVMs[safe: row]
        }
        return nil
    }
    func downloadBooks() {
        viewDelegate?.showIndicator()
        RequestManager.shared.getBooks(completion: downloadBooksCompletion)
    }
    private func downloadBooksCompletion(_ success: Bool, _ books: [Book]) {
        if success {
            booksVMs.removeAll()
            for book in books {
                booksVMs.append(BRBookVM(using: book))
            }
            booksVMs = booksVMs.sorted(by: { $1.title.lowercased() > $0.title.lowercased() })
            viewDelegate?.hideIndicator(success: success)
            viewDelegate?.refreshData()
        } else {
            viewDelegate?.hideIndicator(success: success)
        }
    }
    func downloadBookDetails(for indexPath: IndexPath) {
        if
            indexPath.section == 0,
            let bookVM = booksVMs[safe: indexPath.row] {
            viewDelegate?.showIndicator()
            RequestManager.shared.getBook(withId: bookVM.id, completion: downloadBookDetailsCompletion)
        }
    }
    private func downloadBookDetailsCompletion(_ success: Bool, _ book: Book?) {
        if success {
            viewDelegate?.hideIndicator(success: success)
            let bookVM = BRBookVM(using: book)
            viewDelegate?.goToBookDetailVC(using: bookVM)
        } else {
            viewDelegate?.hideIndicator(success: success)
        }
    }
    
}
