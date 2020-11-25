//
//  UserModel.swift
//  GenericNetwork
//
//  Created by Mohamed Adel on 23/11/2020.
//

import Foundation

class UserModel: Codable {
    var name: String?
    var salary: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "employee_name"
        case salary = "employee_salary"
    }
}
