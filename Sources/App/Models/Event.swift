//
//  Event.swift
//  
//
//  Created by Захар Литвинчук on 26.11.2023.
//

import Vapor
import Fluent

final class Event: Model {
    static var schema: String = "events"
    
    @ID var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "organizator")
    var organizator: String
    
    @Field(key: "year")
    var year: Int
    
    init() { }
    
    init(id: UUID? = nil, title: String, organizator: String, year: Int) {
        self.id = id
        self.title = title
        self.organizator = organizator
        self.year = year
    }
}

extension Event: Content { }
