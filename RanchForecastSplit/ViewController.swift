//
//  ViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 04/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSSplitViewController {
    let fetcher = ScheduleFetcher()
    dynamic var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        fetcher.fetchCoursesUsingCompletionHandler { (result) in
//            switch result {
//            case .Success(let courses):
//                print("Got courses: \(courses)")
//                self.courses = courses
//            case .Failure(let error):
//                print("Got error: \(error)")
//                NSAlert(error: error).runModal()
//                self.courses = []
//            }
//        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

