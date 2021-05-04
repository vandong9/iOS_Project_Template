//
//  RequestProtocol.swift
//  ProjectTemplate
//
//  Created by dongha on 28/04/2021.
//

import Foundation

enum RequestMethod {
    case get
    case post
    case patch
    case put
    case delete
}

enum encodeType {
    case Plaid
    case JSON
}


struct APIResponse {
    let data: Any?
    let error: Error?
}

enum APIError: Error {
    
}

protocol APIProtocol {
    func request(path: String, method: RequestMethod, headers: [String: String], parameters: [String: Any], completionBlock: @escaping (APIResponse)->Void)
}
