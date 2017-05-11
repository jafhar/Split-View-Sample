//
//  MainSplitViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 05/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, CourseListViewControllerDelegate {
    
    var masterViewController: CourseListViewController {
        let masterItem = splitViewItems[0] 
        return masterItem.viewController as! CourseListViewController
    }
    var detailViewController: WebViewController {
        let masterItem = splitViewItems[1] 
        return masterItem.viewController as! WebViewController
    }
    
    let defaultURL = NSURL(string:"https://www.apple.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        masterViewController.delegate = self
        detailViewController.loadURL(url: defaultURL!)
    }
    
    
    //MARK : CourseListViewControllerDelegate
    
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) {
        if let course = selectedCourse {
            detailViewController.loadURL(url: course.url)
        }
        else {
            detailViewController.loadURL(url: defaultURL!)
        }
    }
}
