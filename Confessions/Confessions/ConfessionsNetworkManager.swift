//
//  ConfessionsNetworkManager.swift
//  ChatApp
//
//  Created by Enrique Avina on 8/16/22.
//

import Foundation


func PostRequest(endpoint: String, body: [String: Any], HTTPSUrl: String="https://3iw5293ifj.execute-api.us-east-1.amazonaws.com/development", completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)  {
    
    // Create a URLRequest for an API endpoint
    let url = URL(string: "\(HTTPSUrl)\(endpoint)")!
    var request = URLRequest(url: url)
    
    let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
            
    request.httpMethod = "POST"
    request.httpBody = bodyData
    
    //HTTP Headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
        completionHandler(data, response, error)
    })
    
    task.resume()
}



private var HTTPSUrl = "https://3iw5293ifj.execute-api.us-east-1.amazonaws.com/development"

