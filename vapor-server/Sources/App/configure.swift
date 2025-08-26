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

    // Ensure JSON dates use ISO8601 for decode/encode (matches HTML form)
    let jsonEncoder = JSONEncoder()
    jsonEncoder.dateEncodingStrategy = .iso8601
    ContentConfiguration.global.use(encoder: jsonEncoder, for: .json)
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .iso8601
    ContentConfiguration.global.use(decoder: jsonDecoder, for: .json)

    try routes(app)
}

