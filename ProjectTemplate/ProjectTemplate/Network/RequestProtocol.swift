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

protocol APIProtocol {
    func request(path: String, method: RequestMethod, headers: [String: String], parameters: [String: Any], completionBlock: (Result<Any, Error>)->Void)
}
