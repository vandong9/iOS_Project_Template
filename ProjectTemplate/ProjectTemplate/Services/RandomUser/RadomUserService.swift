//
//  RadomUserService.swift
//  ProjectTemplate
//

import Foundation

class RadomUserService {
    var requester: APIRequest
    
    init(requester: APIRequest = APIRequest(restClient: AlamofireAPIRequest(label: "RadomUserService"))) {
        self.requester = requester
    }
    
    func getRadomService() {
//        requester.
    }
}
