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
    
    public var baseURL: URL { return URL(string: "https://fierce-cove-29863.herokuapp.com")! }
   
    public var path: String {
        switch self {
        case .zen:
            return "/getAllPosts"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .zen:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data() //fake data for unit testing
    }

    public var task: Task {
        switch self {
        case .zen:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public var validationType: ValidationType {
        switch self {
        case .zen:
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

