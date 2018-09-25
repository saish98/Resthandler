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
    
    //MARK: For createUser uncomment this
    //    let identifier: String
    //    let name: String
    //    let job: String?
    //    let createdAt: String
    
    //MARK: For updateUser uncomment this
    //    let name: String?
    //    let job: String?
    //    let updatedAt: String
  
    //MARK: For getUser uncomment this
    //    let identifier: Int
    //    let first_name: String
    //    let last_name: String?
    //    let avatar: String?

    //MARK: For getUsers uncomment this
        let identifier: Int
        let pantone_value: String?
        let name: String
        let color: String?
        let year: Int
    
    
    init(map: Mapper) throws {
        
        //MARK: For createUser uncomment this
        //    try identifier = map.from("id")
        //    try name = map.from("name")
        //    job = map.optionalFrom("job")
        //    try createdAt = map.from("createdAt")
        
        //MARK: For updateUser uncomment this
        //    name = map.optionalFrom("name")
        //    job = map.optionalFrom("job")
        //    try updatedAt = map.from("updatedAt")
        
        //MARK: For getUser uncomment this
        //    try identifier = map.from("id")
        //    try first_name = map.from("first_name")
        //    last_name = map.optionalFrom("last_name")
        //    avatar = map.optionalFrom("avatar")
        
        //MARK: For getUsers uncomment this
            try identifier = map.from("id")
            try name = map.from("name")
            pantone_value = map.optionalFrom("pantone_value")
            color = map.optionalFrom("color")
            try year = map.from("year")

    }
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        //MARK: For createUser uncomment this
        //        return "\n<id:\(identifier) \n name:\(name) \n job:\(String(describing: job)) \n createdAt:\(createdAt)>"
        
        //MARK: For updateUser uncomment this
        //        return "\n<name:\(String(describing: name)) \n job:\(String(describing: job))>"
        
        //MARK: For getUser uncomment this
        //        return "\n<id:\(identifier) \n first_name:\(first_name) \n last_name:\(String(describing: last_name)) \n avatar:\(String(describing: avatar))>"
        
        //MARK: For getUsers uncomment this
        return "\n<id:\(identifier) \n name:\(name) \n pantone_value:\(String(describing: pantone_value)) \n color:\(String(describing: color)) \n year:\(year)>"
    }
}


struct Page: Mappable {
    
    //MARK: For getUsers uncomment this
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [User]
    
    init(map: Mapper) throws {
        try page = map.from("page")
        try per_page = map.from("per_page")
        try total = map.from("total")
        try total_pages = map.from("total_pages")
        data = map.optionalFrom("data") ?? []
    }
 
}

extension Page: CustomDebugStringConvertible {
    var debugDescription: String {
        //MARK: For getUsers uncomment this
        return "\n<page:\(page) \n per_page:\(per_page) \n total:\(total) \n total_pages:\(total_pages) \n data:\(data)>"
    }
}
