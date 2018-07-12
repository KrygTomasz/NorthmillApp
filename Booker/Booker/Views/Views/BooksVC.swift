//
//  BooksVC.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

protocol BooksVCDelegate: class {
    func showIndicator()
    func hideIndicator(success: Bool)
    func refreshData()
    func goToBookDetailVC(using bookVM: BookVM)
}

class BooksVC: UIViewController {

    @IBOutlet weak var booksTableView: UITableView! {
        didSet {
            let bookCellNib = UINib(nibName: "BookTVCell", bundle: nil)
            booksTableView.register(bookCellNib, forCellReuseIdentifier: "BookTVCell")
            booksTableView.delegate = self
            booksTableView.dataSource = self
            booksTableView.contentInset = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)
        }
    }
    
    var booksListVM: BooksListVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        booksListVM = BRBooksListVM(with: self)
        booksListVM?.downloadBooks()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func prepareView() {
        self.view.backgroundColor = UIColor.backgroundColor
        self.prepareNavigationBar(withTitle: "allBooks".localized())
    }
    
//    func getBooks(_ success: Bool, _ books: [Book]) {
//
//    }
    
//    func getBook(_ success: Bool, _ book: Book?) {
//
//    }
    
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
//        goToBookDetailVC(using: (booksListVM?.getBookVM(for: indexPath))!)

    }
}

extension BooksVC: BooksVCDelegate {
    func showIndicator() {
        
    }
    func hideIndicator(success: Bool) {
        
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
}
