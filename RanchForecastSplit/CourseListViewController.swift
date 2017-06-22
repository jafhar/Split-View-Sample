//
//  CourseListViewController.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 05/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate:
class {
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) -> Void
}

class CourseListViewController: NSViewController {
    
    weak var delegate: CourseListViewControllerDelegate? = nil
    
    private dynamic var courses: [Course] = []
    
    private let fetcher = ScheduleFetcher()
    
    @IBOutlet var arrayController: NSArrayController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        //Fetching data
        fetcher.fetchCoursesUsingCompletionHandler(completionHandler: {[weak self](result) in
            guard let weakSelf = self else {return}
            switch result {
            case .Success(let courses):
                print("Got courses : \(courses)")
                weakSelf.courses = courses
            case .Failure(let error):
                print("Got error : \(error)")
                NSAlert (error:error).runModal()
                weakSelf.courses = []
            }})
    }
    
    //MARK:- Action for selected row
    @IBAction func selectCourse(sender: AnyObject) {
        let selectedCourse = arrayController.selectedObjects.first as! Course?
        delegate?.courseListViewController(viewController: self, selectedCourse: selectedCourse)
    }
}
