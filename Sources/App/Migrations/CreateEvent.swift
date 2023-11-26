//
//  CreateEvent.swift
//
//
//  Created by Захар Литвинчук on 26.11.2023.
//

import Fluent

struct CreateEvent: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        
        database.schema("events")
            .id()
            .field("title", .string, .required)
            .field("organizator", .string, .required)
            .field("year", .int, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("events").delete()
    }
        
}
