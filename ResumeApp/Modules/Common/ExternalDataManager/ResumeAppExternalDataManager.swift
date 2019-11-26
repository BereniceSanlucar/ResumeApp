//
//  ResumeAppExternalDataManager.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class ResumeAppExternalDataManager {
    
    static let shared = ResumeAppExternalDataManager()
    var context: NSManagedObjectContext?
    
    private var personName = String()
    
    private init() {
        
    }
    
    func getDataFromExternalSource(completion: @escaping (String) -> Void?) {
        let components : (String, String, [String:String]?) = (host: ResumeAppCommonConstants.URLComponents.host, path: ResumeAppCommonConstants.URLComponents.path, queries: nil)
        
        guard let URL = getURL(requestComponents: components) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL)) { (data, response, error) in
            
            guard error == nil, let data = data, let safeContext = self.context, let keyContext = CodingUserInfoKey.context  else {
                fatalError(ResumeAppCommonConstants.ExternalManagerIdentifiers.retrievingError)
            }
        
            let decoder = JSONDecoder()
            decoder.userInfo[keyContext] = safeContext
            
            do {
                let person = try decoder.decode(Person.self, from: data)
                self.personName = person.name ?? ResumeAppCommonConstants.ModuleTitles.basicInfoTitle
                do {
                    try safeContext.save()
                } catch {
                    fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.retrievingError)
                }
            } catch {
                fatalError(ResumeAppCommonConstants.ExternalManagerIdentifiers.parsingError)
            }
            
            DispatchQueue.main.async(execute: {
                completion(self.personName)
            })
        }
        
        task.resume()
    }
    
    private func getURL(requestComponents: (host: String, path: String, queries: [String:String]?)) -> URL? {
        var components = URLComponents()
        components.scheme = ResumeAppCommonConstants.URLComponents.scheme
        components.host = requestComponents.host
        components.path = requestComponents.path
        
        if let queries = requestComponents.queries {
            components.queryItems = [URLQueryItem]()
            for (key, value) in queries {
                components.queryItems?.append(URLQueryItem(name: key, value: value))
            }
        }
        return components.url
    }
}
