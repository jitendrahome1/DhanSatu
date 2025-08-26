import Vapor
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateStockSignal())

    // Serve Public/ static files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Enable CORS for browser access to API
    let cors = CORSMiddleware(configuration: .init(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .DELETE, .OPTIONS],
        allowedHeaders: [.accept, .contentType, .origin, .authorization]
    ))
    app.middleware.use(cors)

    try routes(app)
}

