//
//  APIManager.swift
//  DecoderPractical
//
//  Created by Muvi on 09/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import Foundation

enum ErrorsToThrow: Error {
    case dataNotFound
    case parsingError
    case wrongURL
}

class APIManager: NSObject {
    
    let baseURL = "http://dcoder.tech/test_json"
    static let sharedInstance = APIManager()
    static let codesEndpoint = "/codes.json"
    static let chatEndpoint = "/chat.json"
    
    func getCodes(onSuccess: @escaping([CodesData]) -> Void, onFailure: @escaping(ErrorsToThrow) -> Void){
        guard let url = URL(string: baseURL + APIManager.codesEndpoint) else {
            onFailure(.wrongURL)
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            guard let data = data else {
                onFailure(.dataNotFound)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([CodesData].self, from: data)
                onSuccess(json)
            }
            catch {
                onFailure(.parsingError)
            }
            
        })
        task.resume()
    }
    
    func getChats(onSuccess: @escaping([ChatData]) -> Void, onFailure: @escaping(ErrorsToThrow) -> Void){
        guard let url = URL(string: baseURL + APIManager.chatEndpoint) else {
            onFailure(.wrongURL)
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            guard let data = data else {
                onFailure(.dataNotFound)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try decoder.decode([ChatData].self, from: data)
                onSuccess(json)
            }
            catch {
                onFailure(.parsingError)
            }
            
        })
        task.resume()
    }
    
}
