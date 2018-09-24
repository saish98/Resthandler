//
//  Article.swift
//  Resthandler
//
//  Created by Heady on 24/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import Mapper
/*
 {
 "id" : 1,
 "title" : "Post One",
 "thumbUrl" : "https:\/\/lh6.googleusercontent.com\/-55osAWw3x0Q\/URquUtcFr5I\/AAAAAAAAAbs\/rWlj1RUKrYI\/s240-c\/A%252520Photographer.jpg",
 "url" : "https:\/\/lh6.googleusercontent.com\/-55osAWw3x0Q\/URquUtcFr5I\/AAAAAAAAAbs\/rWlj1RUKrYI\/s1024\/A%252520Photographer.jpg"
 },

 */
struct Article: Mappable {
    
    let identifier: Int
    let title: String
    let thumbUrl: String
    let url: String
    let language: String?
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try title = map.from("title")
        try thumbUrl = map.from("thumbUrl")
        try url = map.from("url")
        language = map.optionalFrom("language") 
    }
}

extension Article: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\n<id:\(identifier) \n title:\(title) \n thumbUrl:\(thumbUrl) \n url:\(url) \n language:\(String(describing: language))>"
    }
}

