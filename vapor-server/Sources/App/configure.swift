import Vapor
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) throws {
    
    // 👇 Set custom host & port here
      app.http.server.configuration.hostname = "0.0.0.0"   // listens on all interfaces
      app.http.server.configuration.port = 8080            // change to your port
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

    // Configure flexible date handling for JSON
    let jsonEncoder = JSONEncoder()
    jsonEncoder.dateEncodingStrategy = .iso8601
    ContentConfiguration.global.use(encoder: jsonEncoder, for: .json)
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        // Try ISO8601 format first
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            return date
        }
        
        // Try various other formats
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd"
        ]
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Date string does not match any expected format: \(dateString)"
        )
    }
    ContentConfiguration.global.use(decoder: jsonDecoder, for: .json)

    try routes(app)
}

