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
    func reloadBookData()
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
    lazy var addBarButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddBarButtonClicked))
    var booksListVM: BooksListVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        self.navigationItem.rightBarButtonItem = addBarButton
        self.view.backgroundColor = UIColor.backgroundColor
        self.prepareNavigationBar(withTitle: "allBooks".localized())
        booksListVM = BRBooksListVM(with: self)
        self.reloadBookData()
    }
    private func getDeleteAlert(for bookVM: BookVM) -> UIAlertController {
        let alertMessage = String(format: "bookDeleteConfirmationQuestion".localized(), bookVM.title)
        let alert = UIAlertController(title: "bookDelete".localized(), message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "delete".localized(), style: .destructive) { action in
            bookVM.deleteBook(completion: { [weak self]
                success in
                self?.hideIndicator(success: success)
                self?.reloadBookData()
            })
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        return alert
    }
    func showDeleteAlert(for bookVM: BookVM) {
        let alert = getDeleteAlert(for: bookVM)
        self.present(alert, animated: true)
    }
    @objc func onAddBarButtonClicked() {
        showAddNewBookVC()
    }
    private func getAddNewBookVC() -> AddNewBookVC {
        let vc = AddNewBookVC.getInstance(using: self)
        return vc
    }
    func showAddNewBookVC() {
        let addNewBookVC = getAddNewBookVC()
        addNewBookVC.view.alpha = 0
        self.present(addNewBookVC, animated: false, completion: { [weak self] in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    addNewBookVC.view.alpha = 1
                })
            }
        })
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
}
