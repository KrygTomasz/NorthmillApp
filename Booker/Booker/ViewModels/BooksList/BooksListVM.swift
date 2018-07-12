//
//  BooksListVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

protocol BooksListVM {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func getBookVM(for indexPath: IndexPath) -> BookVM?
    func downloadBooks()
    func downloadBookDetails(for indexPath: IndexPath)
}
