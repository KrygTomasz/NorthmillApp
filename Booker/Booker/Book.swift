//
//  Book.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

protocol Book {
    var Id: String { get }
    var Title: String { get }
    var CoverUrl: String? { get }
    var Description: String? { get }
}
