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
    }
    
    func prepareView() {
        self.view.backgroundColor = UIColor.backgroundColor
        self.prepareNavigationBar(withTitle: "allBooks".localized())
        booksListVM = BRBooksListVM(with: self)
        booksListVM?.downloadBooks()
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
