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
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func fetchCoursesUsingCompletionHandler(completionHandler:
        @escaping (FetchCoursesResult) -> (Void)) {
//        let url = NSURL(string: "https://bookapi.bignerdranch.com/courses.json")!
//        let request = NSURLRequest(url: url as URL)
//        let task = session.dataTask(with: request as URLRequest, completionHandler: {
//            (data, response, error) -> Void in
//            var result: FetchCoursesResult
//            
//            if data == nil {
//                result = .Failure(error! as NSError)
//            }
//            else if let response = response as? HTTPURLResponse {
//                print("\(String(describing: data?.count)) bytes, HTTP \(response.statusCode).")
//                if response.statusCode == 200 {
//                    result = try! self.resultFromData(data: data! as NSData)
//                }
//                else {
//                    let error = self.errorWithCode(1, localizedDescription:
//                        "Bad status code \(response.statusCode)")
//                    result = .Failure(error)
//                }
//            }
//            else {
//                let error = self.errorWithCode(1, localizedDescription:
//                    "Unexpected response object.")
//                result = .Failure(error)
//            }
//            OperationQueue.main.addOperation({
//                completionHandler(result)
//            })
//        })
//        task.resume()
        var result: FetchCoursesResult
        
        let url = Bundle.main.url(forResource: "cources", withExtension: "json")
        
        if let url = url {
            do {
                let data = try Data.init(contentsOf:url, options: Data.ReadingOptions.init(rawValue: 1))
                print("\(String(describing: data.count))")
                result = try! self.resultFromData(data: data as NSData)
            } catch let error {
                 result = .Failure(error as NSError)
            }
            OperationQueue.main.addOperation({
                completionHandler(result)
            })
        }
    }
    
    func errorWithCode(_ code: Int, localizedDescription: String) -> NSError {
        return NSError(domain: "ScheduleFetcher",
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    
    func courseFromDictionary(courseDict: NSDictionary) -> Course? {
        let title = courseDict["title"] as! String
        let urlString = courseDict["url"] as! String
        let upcomingArray = courseDict["upcoming"] as! [NSDictionary]
        let nextUpcomingDict = upcomingArray.first!
        let nextStartDateString = nextUpcomingDict["start_date"] as! String
        
        let url = NSURL(string: urlString)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextStartDate = dateFormatter.date(from: nextStartDateString)!
        
        return Course(title: title, url: url, nextStartDate: nextStartDate as NSDate)
    }
    
    
    func resultFromData(data: NSData) throws-> FetchCoursesResult {
        var topLevelDict:NSDictionary?
       do {
        topLevelDict = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
       } catch let error {
        print("\(error.localizedDescription)")
        return .Failure(error as NSError)
        }
//        let topLevelDict = JSONSerialization.JSONObjectWithData(data,
//                                                                  options: JSONSerialization.ReadingOptions.allZeros,
//                                                                  error: &error) as! NSDictionary?
        
        if let topLevelDict = topLevelDict {
            let courseDicts = topLevelDict["courses"] as! [NSDictionary]
            var courses: [Course] = []
            for courseDict in courseDicts {
                if let course = courseFromDictionary(courseDict: courseDict) {
                    courses.append(course)
                }
            }
            return .Success(courses)
        }
        else
        {
            return .Failure(NSError.init(domain: "Test", code: 404, userInfo: nil))
        }

    }
}


