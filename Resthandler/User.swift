//
//  User.swift
//  Resthandler
//
//  Created by Heady on 25/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import Mapper
/*
 {
 "name": "morpheus",
 "job": "leader",
 "id": "309",
 "createdAt": "2018-09-24T20:21:08.630Z"
 }
 */
struct User: Mappable {
    
    let createdAt: String
    let identifier: String
    let name: String
    let job: String
    
    init(map: Mapper) throws {
        try createdAt = map.from("createdAt")
        try identifier = map.from("id")
        try name = map.from("name")
        try job = map.from("job")
    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\n<id:\(identifier) \n name:\(name) \n job:\(job) \n createdAt:\(createdAt)>"
    }
}
