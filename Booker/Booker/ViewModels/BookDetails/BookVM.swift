//
//  BookVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 12.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

protocol BookVM {
    var id: String { get }
    var title: String { get }
    var description: String { get }
    var imageUrl: String { get }
    func downloadImage(completion: @escaping ((UIImage?) -> Void))
    func deleteBook(completion: @escaping ((Bool) -> Void))
}
