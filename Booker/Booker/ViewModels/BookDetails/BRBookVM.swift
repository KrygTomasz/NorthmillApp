//
//  BRBookVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

//MARK: BookVM implementation
class BRBookVM: BookVM {
    
    //MARK: Initializer
    init(using book: Book?) {
        self.book = book
    }
    
    //MARK: Variables
    var book: Book?
    var id: String {
        return book?.Id ?? ""
    }
    var title: String {
        return book?.Title ?? ""
    }
    var description: String {
        return book?.Description ?? ""
    }
    var imageUrl: String {
        return book?.CoverUrl ?? ""
    }
    
    //MARK: Methods
    func downloadImage(completion: @escaping ((UIImage?) -> Void)) {
        RequestManager.shared.downloadImage(from: imageUrl, completion: completion)
    }
    func deleteBook(completion: @escaping ((Bool) -> Void)) {
        RequestManager.shared.deleteBook(withId: id, completion: completion)
    }
    
}
