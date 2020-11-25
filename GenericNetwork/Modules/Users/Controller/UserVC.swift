//
//  UserVC.swift
//  GenericNetwork
//
//  Created by Mohamed Adel on 11/25/20.
//

import UIKit

class UserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api: UsersAPIProtocol = UsersAPI()
        api.getUsers { (result) in
            switch result {
            case .success(let response):
                let users = response?.data
                for user in users ?? [] {
                    print("\(user.name ?? "") => \(user.salary ?? "")")
                }
            case .failure(let error):
                print(error.userInfo[NSLocalizedDescriptionKey] as? String ?? "")
            }
        }
    }
}
