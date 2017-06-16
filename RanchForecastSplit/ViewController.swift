//
//  ViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 04/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class ViewController: NSSplitViewController {
    private let fetcher = ScheduleFetcher()
    private dynamic var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

