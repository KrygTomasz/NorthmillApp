//
//  BRBook.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

class BRBook: Book, Codable {
    var Id: String
    var Title: String
    var CoverUrl: String?
    var Description: String?
    init(id: String, title: String, description: String? = nil, coverUrl: String? = nil) {
        self.Id = id
        self.Title = title
        self.CoverUrl = coverUrl
        self.Description = description
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.Id = try values.decode(String.self, forKey: .Id)
        self.Title = try values.decode(String.self, forKey: .Title)
        self.CoverUrl = try values.decodeIfPresent(String.self, forKey: .CoverUrl) ?? ""
        self.Description = try values.decodeIfPresent(String.self, forKey: .Description) ?? ""
    }
    
}
