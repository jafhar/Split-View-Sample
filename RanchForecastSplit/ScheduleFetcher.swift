//
//  ScheduleFetcher.swift
//  RanchForecastSplit
//
//  Created by jafharsharief.b on 04/05/17.
//  Copyright © 2017 Exilant. All rights reserved.
//

import Foundation

class ScheduleFetcher {
    
    enum FetchCoursesResult {
        case Success([Course])
        case Failure(NSError)
    }
    
    //This was used earlier for web service part which's removed
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    //MARK - Fetching Course data from json , we can load it using web service request too
    func fetchCoursesUsingCompletionHandler(completionHandler:
        @escaping (FetchCoursesResult) -> (Void)) {
        var result: FetchCoursesResult
        
        let url = Bundle.main.url(forResource: "cources", withExtension: "json")
        
        if let url = url {
            do {
                let data = try Data(contentsOf: url, options: .alwaysMapped)
                print("\(String(describing: data.count))")
                
                //handle the error thrown
                do {
                    result = try self.resultFromData(data: data as NSData)
                } catch let error {
                    result = .Failure(error as NSError)
                }
                
            } catch let error {
                result = .Failure(error as NSError)
            }
            OperationQueue.main.addOperation({
                completionHandler(result)
            })
        }
    }
    
    //MARK - Common method to represent error while fetching data from the server
    //currently not using, was used earlier for web request
    private func errorWithCode(_ code: Int, localizedDescription: String) -> NSError {
        return NSError(domain: Constant.domainName,
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    //MARK - Creating Course object from Dictionary
    private func courseFromDictionary(courseDict: NSDictionary) -> Course? {
        let title = courseDict[Constant.titleKey] as? String
        let urlString = courseDict[Constant.urlKey] as? String
        let upcomingArray = courseDict[Constant.upcomingKey] as? [NSDictionary]
        let nextUpcomingDict = upcomingArray?.first
        let nextStartDateString = nextUpcomingDict?[Constant.startDateKey] as? String
        
        let url:NSURL
        if let stringForURL = urlString {
            url = NSURL(string: (stringForURL))!
        }
        else {
            url = NSURL(string:Constant.defaultURL)!
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.defaultDateFormat
        let nextStartDate : Date
        if let startDateString = nextStartDateString  {
            nextStartDate = dateFormatter.date(from: startDateString)!
        }
        else {
            nextStartDate = Date()
        }
        if let title = title {
            return Course(title: title, url: url, nextStartDate: nextStartDate as NSDate)
        }
        else {
            return Course(title: Constant.defaultTitle, url: url, nextStartDate: nextStartDate as NSDate)
        }
    }
    
    //MARK - preparing FetchCoursesResult
    private func resultFromData(data: NSData) throws-> FetchCoursesResult {
        var topLevelDict:NSDictionary?
        do {
            topLevelDict = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        } catch let error {
            print("\(error.localizedDescription)")
            return .Failure(error as NSError)
        }
        
        if let topLevelDict = topLevelDict {
            let courseDicts = topLevelDict[Constant.courcesKey] as? [NSDictionary]
            var courses: [Course] = []
            if let courseDicts = courseDicts {
                for courseDict in courseDicts {
                    if let course = courseFromDictionary(courseDict: courseDict) {
                        courses.append(course)
                    }
                }
                return .Success(courses)
            }
            else {
                return .Failure(NSError.init(domain: Constant.domainName, code: 404, userInfo: nil))
            }
        }
        else
        {
            return .Failure(NSError.init(domain: Constant.domainName, code: 404, userInfo: nil))
        }
    }
}


