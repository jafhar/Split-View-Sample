//
//  Course.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 04/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class Course: NSObject {
    let title: String
    let url: NSURL
    let nextStartDate: NSDate
    
    init(title: String, url: NSURL, nextStartDate: NSDate) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
        super.init()
    }
}
