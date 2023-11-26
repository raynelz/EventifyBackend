//
//  EventsController.swift
//
//
//  Created by Захар Литвинчук on 27.11.2023.
//

import Vapor
import Fluent

struct EventsController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let eventsRoutes = routes.grouped("api", "events")
        eventsRoutes.get(use: getAllHandler)
        eventsRoutes.get(":eventID", use: getHandler)
        eventsRoutes.post( use: createHandler)
        eventsRoutes.put(":eventID", use: updateHandler)
        eventsRoutes.delete(":eventID", use: deleteHandler)
    }
    
    //CRUD - Retrieve (Получение ивентов)
    func getAllHandler(_ req: Request) -> EventLoopFuture<[Event]> {
        Event.query(on: req.db).all()
    }
    
    //CRUD - Retrieve (Получение одного ивента по ID)
    func getHandler(_ req: Request) -> EventLoopFuture<Event> {
        Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    //CRUD - Create (Создание ивента)
    func createHandler(_ req: Request) throws -> EventLoopFuture<Event> {
        let event = try req.content.decode(Event.self)
        return event.save(on: req.db).map { event }
    }
    
    //CRUD - Update (Изменить данные ивента по ID)
    func updateHandler(_ req: Request) throws -> EventLoopFuture<Event> {
        let updatedEvent = try req.content.decode(Event.self)
        let event = Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { event in
                event.title = updatedEvent.title
                event.organizator = updatedEvent.organizator
                event.year = updatedEvent.year
                
                return event.save(on: req.db).map { event }
            }
        return event
    }
    
    //CRUD - Delete (Удаление ивента по ID)
    func deleteHandler(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Event.find(req.parameters.get("eventID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { event in
                event.delete(on: req.db)
                    .transform(to: .noContent)
            }
    }
}
