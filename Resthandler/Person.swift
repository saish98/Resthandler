//
//  Response.swift
//  Resthandler
//
//  Created by Heady on 25/09/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import Mapper

struct Person: Mappable {
    
    let identifier: String
    let name: String
   
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try name = map.from("name")
    }
}


