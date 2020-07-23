//
//  GetAllDataRequest.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation

class GetAllDataRequest : APIRequest {
    
    var postParameters: [String : Any]?
    var urlParameters: [String : Any]?

    var method: RequestType {
        return .GET
    }
    var path: String = Endpoints.getAllData
}
