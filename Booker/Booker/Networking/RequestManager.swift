//
//  RequestManager.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import Foundation

//MARK: Request completion types
typealias GetBooksCompletion = ((Bool, [Book]) -> Void)
typealias GetBookCompletion = ((Bool, Book?) -> Void)
typealias AddBookCompletion = ((Bool) -> Void)
typealias DeleteBookCompletion = ((Bool) -> Void)

final class RequestManager {
    
    private init() { }
    static let shared = RequestManager()
    
    //MARK: Constants
    private let urlAddress = "http://apitest-northmill.azurewebsites.net/api/"
    private let booksEndpoint = "Books"
    private let bookEndpoint = "Book"
    
    //MARK: Helper methods
    private func getRequest(usingHttpMethod httpMethod: String?, forEndpoint endpoint: String, withBody httpBody: Data? = nil) -> URLRequest? {
        let address = urlAddress + endpoint
        guard let url = URL(string: address) else { return nil }
        var request = URLRequest(url: url)
        request.timeoutInterval = GlobalValues.TIMEOUT_INTERVAL
        request.httpMethod = httpMethod
        request.httpBody = httpBody
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
    private func getAddBookBody(using book: Book) -> [String : String?] {
        let parameters = [
            "Title" : book.Title,
            "Description" : book.Description ?? "",
            "CoverUrl" : book.CoverUrl
        ]
        return parameters
    }
    
}

//MARK: Api requests methods
extension RequestManager {
    
    //MARK: GET Book List
    func getBooks(completion: @escaping GetBooksCompletion) {
        guard let request = getRequest(usingHttpMethod: "GET", forEndpoint: booksEndpoint) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, [])
            }
            guard let data = data else {
                completion(false, [])
                return
            }
            do {
                let books = try JSONDecoder().decode([BRBook].self, from: data)
                completion(true, books)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, [])
            }
        }.resume()
    }
    
    //MARK: GET Book
    func getBook(withId id: String, completion: @escaping GetBookCompletion) {
        let endpoint = bookEndpoint + "/\(id)"
        guard let request = getRequest(usingHttpMethod: "GET", forEndpoint: endpoint) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false, nil)
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                let book = try JSONDecoder().decode(BRBook.self, from: data)
                completion(true, book)
            } catch let jsonError {
                NSLog(jsonError.localizedDescription)
                completion(false, nil)
            }
        }.resume()
    }
    
    //MARK: POST Book
    func addBook(_ book: Book?, completion: @escaping AddBookCompletion) {
        guard let bookToAdd = book else {
            completion(false)
            return
        }
        let endpoint = bookEndpoint
        let parameters = getAddBookBody(using: bookToAdd)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        guard let request = getRequest(usingHttpMethod: "POST", forEndpoint: endpoint, withBody: httpBody) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog(error.localizedDescription)
                completion(false)
                return
            }
            guard let data = data else {
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
    
    //MARK: DELETE Book
    func deleteBook(withId id: String, completion: @escaping DeleteBookCompletion) {
        let endpoint = bookEndpoint + "/\(id)"
        guard let request = getRequest(usingHttpMethod: "DELETE", forEndpoint: endpoint) else { return }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if
                let error = error {
                NSLog(error.localizedDescription)
                completion(false)
                return
            }
            guard let data = data else {
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
    
}
