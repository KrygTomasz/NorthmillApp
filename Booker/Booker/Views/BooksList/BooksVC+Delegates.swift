//
//  BooksVC+Delegates.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: Delegate definitions
protocol BooksVCDelegate: class {
    func showIndicator()
    func hideIndicator(success: Bool)
    func reloadBookData()
    func refreshData()
    func goToBookDetailVC(using bookVM: BookVM)
    func showSuccessfulAddBookAlert()
}

//MARK: UITableView delegates
extension BooksVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return booksListVM?.numberOfSections ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksListVM?.numberOfRows(in: section) ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookTVCell", for: indexPath) as? BookTVCell
            else {
                return UITableViewCell()
        }
        return bookCell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let bookCell = cell as? BookTVCell else { return }
        let bookVM = booksListVM?.getBookVM(for: indexPath)
        bookCell.prepare(using: bookVM)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        booksListVM?.downloadBookDetails(for: indexPath)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if
            editingStyle == .delete,
            let bookVM = booksListVM?.getBookVM(for: indexPath) {
            showDeleteAlert(for: bookVM)
        }
    }
}

//MARK: BooksVCDelegate
extension BooksVC: BooksVCDelegate {
    func showIndicator() {
        
    }
    func hideIndicator(success: Bool) {
        
    }
    func reloadBookData() {
        booksListVM?.downloadBooks()
    }
    func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.booksTableView.reloadData()
        }
    }
    func goToBookDetailVC(using bookVM: BookVM) {
        DispatchQueue.main.async { [weak self] in
            let bookVC = BookDetailsVC.getInstance(using: bookVM)
            self?.navigationController?.pushViewController(bookVC, animated: true)
        }
    }
    func showSuccessfulAddBookAlert() {
        let alert = getSuccessfulAddBookAlert()
        self.present(alert, animated: true, completion: nil)
    }
}
