//
//  DefaultRestAPIRequest.swift
//  ProjectTemplate
//
//  Created by ha van dong on 5/2/21.
//

import Foundation

class APIRequest {
    var restClient: APIProtocol
    
    init(restClient: APIProtocol) {
        self.restClient = restClient
    }
    
    func request() {
        
    }
}
