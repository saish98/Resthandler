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
    case zen
    case createUser(name: String, job: String)
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
    
//    public var baseURL: URL { return URL(string: "https://fierce-cove-29863.herokuapp.com")! }
    public var baseURL: URL { return URL(string: "https://reqres.in")! }
   
    public var path: String {
        switch self {
        case .zen:
            return "/getAllPosts"
        case .createUser(_, _):
            return "/api/users"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .zen:
            return .get
        case .createUser:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data() //fake data for unit testing
    }

    public var task: Task {
        switch self {
        case .zen:
            return .requestPlain
        case let .createUser(name, job):
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public var validationType: ValidationType {
        switch self {
        case .zen, .createUser:
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

