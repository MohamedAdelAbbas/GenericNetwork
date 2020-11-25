//
//  BaseResponse.swift
//  GenericNetwork
//
//  Created by Mohamed Adel on 23/11/2020.
//

import Foundation


class BaseResponse<T: Codable>: Codable {
    var status: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
