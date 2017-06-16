//
//  MainSplitViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 05/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, CourseListViewControllerDelegate {
    
    private var masterViewController: CourseListViewController {
        let masterItem = splitViewItems[0] 
        return masterItem.viewController as! CourseListViewController
    }
    private var detailViewController: WebViewController {
        let masterItem = splitViewItems[1] 
        return masterItem.viewController as! WebViewController
    }
    
    private let defaultURL = NSURL(string:Constant.defaultURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        masterViewController.delegate = self
        detailViewController.load(url: defaultURL!)
    }
    
    
    //MARK : CourseListViewControllerDelegate
    
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) {
        if let course = selectedCourse {
            detailViewController.load(url: course.url)
        }
        else {
            detailViewController.load(url: defaultURL!)
        }
    }
}
