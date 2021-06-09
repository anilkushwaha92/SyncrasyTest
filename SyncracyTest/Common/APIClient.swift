//
//  APIClient.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import Foundation

protocol APIClientProtocol {
    func getList(url: String, completion: @escaping (Data?) -> Void)
}

class APIClient: APIClientProtocol {
    
    func getList(url: String, completion: @escaping (Data?) -> Void) {
     
        // Create URL
        let url = URL(string: url)
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("bf37b03c45679197fe51bcd8a48c79ff68414f4f23d254aba0fcedcb4ef4240b", forHTTPHeaderField: "apikey")

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                completion(nil)
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                completion(data)
            }
            
        }
        
        task.resume()

    }
}
