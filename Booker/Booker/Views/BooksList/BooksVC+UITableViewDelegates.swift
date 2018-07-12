//
//  BooksVC+UITableViewDelegates.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

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
    
}
