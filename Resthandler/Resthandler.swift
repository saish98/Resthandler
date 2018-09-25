//
//  Resthandler.swift
//  Resthandler
//
//  Created by Heady on 23/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import Moya

public enum Resthandler {
    case getArticles
    case create(name: String, job: String)
    case update(id:String, name:String, job:String)
    case delete(id:String)
    case getUser(id:String)
    case getUsers
}

//MARK: For debug purpose use this provider
let apiLogProvider = MoyaProvider<Resthandler>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

let apiProvider = MoyaProvider<Resthandler>()

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

extension Resthandler: TargetType {
    
    public var baseURL: URL {
        if API.type == .getArticles {
            return URL(string: "https://fierce-cove-29863.herokuapp.com")!
        }else {
            return URL(string: "https://reqres.in")!
        }
    }
   
    public var path: String {
        switch self {
        case .getArticles:
            return "/getAllPosts"
        case .create(_, _):
            return "/api/users"
        case .getUser(let id), .update(let id, _, _), .delete(let id):
            return "/api/users/\(id)"
        case .getUsers:
            return "/api/users?page=2"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getArticles, .getUser, .getUsers:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    public var sampleData: Data {
        return Data() //fake data for unit testing
    }

    public var task: Task {
        switch self {
        case .getArticles, .getUser, .getUsers, .delete:
            return .requestPlain
        case let .create(name, job):
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        case .update( _, let name, let job):
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public var validationType: ValidationType {
        switch self {
        case .getArticles, .create, .update, .delete, .getUser, .getUsers:
            return .successCodes
        }
    }
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

