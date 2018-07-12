//
//  RequestManager.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

typealias BooksCompletion = ((Bool, [Book]) -> ())
typealias BookCompletion = ((Bool, Book?) -> ())

final class RequestManager {
    
    private init() { }
    static let shared = RequestManager()
    
    private let urlAddress = "http://apitest-northmill.azurewebsites.net/api/"
    private let booksEndpoint = "Books"
    private let bookEndpoint = "Book"
    
    private func getRequest(usingHttpMethod httpMethod: String?, forEndpoint endpoint: String) -> URLRequest? {
        let address = urlAddress + endpoint
        guard let url = URL(string: address) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(getBasicAuth(), forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func getBasicAuth() -> String {
        let username = "test"
        let password = "BBTJcpfIpHrnzW25fyxvNsHP0Mk7IrAd"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return "Basic \(base64LoginString)"
    }
    
}

//MARK: Api requests methods
extension RequestManager {
    
    func getBooks(completion: @escaping BooksCompletion) {
        guard let request = getRequest(usingHttpMethod: "GET", forEndpoint: booksEndpoint) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, [])
            }
            guard let data = data else { return }
            do {
                let books = try JSONDecoder().decode([BRBook].self, from: data)
                completion(true, books)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, [])
            }
        }.resume()
    }
    
    func getBook(withId id: String, completion: @escaping BookCompletion) {
        let endpoint = bookEndpoint + "/\(id)"
        guard let request = getRequest(usingHttpMethod: "GET", forEndpoint: endpoint) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, nil)
            }
            guard let data = data else { return }
            do {
                let book = try JSONDecoder().decode(BRBook.self, from: data)
                completion(true, book)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, nil)
            }
        }.resume()
    }
    
}

//MARK: Downloading image from url
extension RequestManager {
    
    private func getDataFromUrl(url: URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let url = url else {
            print("Getting data from url failed. Wrong format for URL address.")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(from urlAddress: String, completion: @escaping (UIImage?)->()) {
        guard let url = URL(string: urlAddress) else { return }
        getDataFromUrl(url: url) { data, response, error in
            guard
                let data = data,
                error == nil
                else {
                    completion(nil)
                    return
            }
            completion(UIImage(data: data))
        }
    }
    
}
