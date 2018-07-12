//
//  ViewController.swift
//  Booker
//
//  Created by Kryg Tomasz on 11.07.2018.
//  Copyright © 2018 Kryg Tomasz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.shared.getBooks(completion: getBooks)
        RequestManager.shared.getBook(withId: "24b6b36a-18fd-4eda-bff9-27e766667b7f", completion: getBook)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getBooks(_ success: Bool, _ books: [Book]) {
        
    }
    
    func getBook(_ success: Bool, _ book: Book?) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

