//
//  BRBookVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class BRBookVM: BookVM {
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
    init(using book: Book?) {
        self.book = book
    }
    func downloadImage(completion: @escaping ((UIImage?) -> Void)) {
        RequestManager.shared.downloadImage(from: imageUrl, completion: completion)
    }
}
