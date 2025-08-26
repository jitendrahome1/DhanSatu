import Vapor
import Fluent

struct StockSignal: Content, Model {
    static let schema = "stock_signals"
    @ID(key: .id) var id: UUID?
    @Field(key: "stockName") var stockName: String
    @Field(key: "currentPrice") var currentPrice: Double
    @Field(key: "profitPercent") var profitPercent: Double
    @Field(key: "stopLoss") var stopLoss: Double
    @Field(key: "target") var target: Double
    @Field(key: "status") var status: String
    @Field(key: "entryDate") var entryDate: Date
    @Timestamp(key: "createdAt", on: .create) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update) var updatedAt: Date?

    init() {}
}

struct CreateStockSignal: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(StockSignal.schema)
            .id()
            .field("stockName", .string, .required)
            .field("currentPrice", .double, .required)
            .field("profitPercent", .double, .required)
            .field("stopLoss", .double, .required)
            .field("target", .double, .required)
            .field("status", .string, .required)
            .field("entryDate", .datetime, .required)
            .field("createdAt", .datetime)
            .field("updatedAt", .datetime)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema(StockSignal.schema).delete()
    }
}

func routes(_ app: Application) throws {
    app.get { req async throws in
        return "Dhansatu Vapor Server is running"
    }

    let signals = app.grouped("api", "signals")

    signals.get { req async throws -> [StockSignal] in
        try await StockSignal.query(on: req.db).sort(.id, .descending).all()
    }

    signals.get(":id") { req async throws -> StockSignal in
        guard let id = req.parameters.get("id", as: UUID.self),
              let signal = try await StockSignal.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        return signal
    }

    signals.post { req async throws -> StockSignal in
        let input = try req.content.decode(StockSignal.self)
        let entity = StockSignal()
        entity.stockName = input.stockName
        entity.currentPrice = input.currentPrice
        entity.profitPercent = input.profitPercent
        entity.stopLoss = input.stopLoss
        entity.target = input.target
        entity.status = input.status
        entity.entryDate = input.entryDate
        try await entity.save(on: req.db)
        return entity
    }

    signals.put(":id") { req async throws -> StockSignal in
        let input = try req.content.decode(StockSignal.self)
        guard let id = req.parameters.get("id", as: UUID.self),
              let entity = try await StockSignal.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        entity.stockName = input.stockName
        entity.currentPrice = input.currentPrice
        entity.profitPercent = input.profitPercent
        entity.stopLoss = input.stopLoss
        entity.target = input.target
        entity.status = input.status
        entity.entryDate = input.entryDate
        try await entity.save(on: req.db)
        return entity
    }

    signals.delete(":id") { req async throws -> HTTPStatus in
        guard let id = req.parameters.get("id", as: UUID.self),
              let entity = try await StockSignal.find(id, on: req.db) else {
            throw Abort(.notFound)
        }
        try await entity.delete(on: req.db)
        return .noContent
    }
}

