//
//  AddNewBookVM.swift
//  Booker
//
//  Created by Kryg Tomasz on 13.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

enum AddBookStatus {
    case successful
    case noTitle
    case noDescription
}

import Foundation

protocol AddNewBookVM {
    var title: String { get set }
    var description: String { get set }
    var imageUrl: String { get set }
    func tryToAdd() -> AddBookStatus
}
