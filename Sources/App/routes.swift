import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let eventsController = EventsController()
    try app.register(collection: eventsController)
    
}
