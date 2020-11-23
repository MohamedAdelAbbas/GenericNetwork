//
//  ViewController.swift
//  GenericNetwork
//
//  Created by Mohamed Adel on 23/11/2020.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchUserData { (response) in
//            switch response{
//            case .success(let users):
//                guard let users = users else { return }
//                for user in users {
//                    print("id -> \(user.id), name -> \(user.name), email -> \(user.email), username -> \(user.userName), company name -> \(user.company?.name)")
//                }
//            case.failure(_):
//                print("Error")
//            }
//        }
//        fetchPostData { (response) in
//            switch response{
//            case .success(let posts):
//                guard let posts = posts else { return }
//                for post in posts {
//                    print("id -> \(post.id), title -> \(post.title), body -> \(post.body)")
//                }
//            case.failure(_):
//                print("Error")
//            }
//        }
        
        fetchData(url: "https://jsonplaceholder.typicode.com/posts", responseClass: [PostModel].self) { (response) in
            switch response{
            case .success(let posts):
                guard let posts = posts else { return }
                for post in posts {
                    print("id -> \(post.id), title -> \(post.title), body -> \(post.body)")
                }
            case.failure(_):
                print("Error")
            }
        }
    }
    
    func fetchData<T: Decodable>(url: String, responseClass: T.Type , completion:@escaping (Result<T?, NSError>) -> Void ) {
        AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
            guard let statuscode = response.response?.statusCode else { return }
            if statuscode == 200 {
                guard let jsonResponse = try? response.result.get() else { return }
                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJsonData) else { return }
                completion(.success(responseObj))
            }
        }
    }
//    func fetchUserData(completion:@escaping (Result<[UserModel]?, NSError>) -> Void) {
//        let url = "https://jsonplaceholder.typicode.com/users"
//        AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
//            guard let statuscode = response.response?.statusCode else { return }
//            if statuscode == 200 {
//                guard let jsonResponse = try? response.result.get() else { return }
//                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
//                guard let responseObj = try? JSONDecoder().decode([UserModel].self, from: theJsonData) else { return }
//                completion(.success(responseObj))
//            }
//        }
//    }
//    func fetchPostData(completion:@escaping (Result<[PostModel]?, NSError>) -> Void) {
//        let url = "https://jsonplaceholder.typicode.com/posts"
//        AF.request(url, method: .get, parameters: [:], headers: [:]).responseJSON { (response) in
//            guard let statuscode = response.response?.statusCode else { return }
//            if statuscode == 200 {
//                guard let jsonResponse = try? response.result.get() else { return }
//                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else { return }
//                guard let responseObj = try? JSONDecoder().decode([PostModel].self, from: theJsonData) else { return }
//                completion(.success(responseObj))
//            }
//        }
//    }
}

class UserModel: Decodable {
    //MARK:- Properties
    var id: Int?
    var name: String?
    var email: String?
    var userName: String?
    var company: CompanyModel?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case userName = "username"
        case company
    }
}

class CompanyModel: Decodable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}

class PostModel: Decodable {
    var id: Int?
    var title: String?
    var body: String?
}
