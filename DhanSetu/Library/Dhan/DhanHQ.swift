//import Foundation
//
//public class DhanHQ {
//    // MARK: - Constants
//    public static let NSE = "NSE_EQ"
//    public static let BSE = "BSE_EQ"
//    public static let CUR = "NSE_CURRENCY"
//    public static let MCX = "MCX_COMM"
//    public static let FNO = "NSE_FNO"
//    public static let NSE_FNO = "NSE_FNO"
//    public static let BSE_FNO = "BSE_FNO"
//    public static let INDEX = "IDX_I"
//
//    public static let BUY = "BUY"
//    public static let SELL = "SELL"
//
//    public static let CNC = "CNC"
//    public static let INTRA = "INTRADAY"
//    public static let MARGIN = "MARGIN"
//    public static let CO = "CO"
//    public static let BO = "BO"
//    public static let MTF = "MTF"
//
//    public static let LIMIT = "LIMIT"
//    public static let MARKET = "MARKET"
//    public static let SL = "STOP_LOSS"
//    public static let SLM = "STOP_LOSS_MARKET"
//
//    public static let DAY = "DAY"
//    public static let IOC = "IOC"
//
//    public static let COMPACT_CSV_URL = "https://images.dhan.co/api-data/api-scrip-master.csv"
//    public static let DETAILED_CSV_URL = "https://images.dhan.co/api-data/api-scrip-master-detailed.csv"
//
//    // MARK: - Properties
//    private let clientId: String
//    private let accessToken: String
//    private let baseUrl = "https://api.dhan.co/v2"
//    private let timeout: TimeInterval = 60
//    private var session: URLSession
//
//    // MARK: - Init
//    public init(clientId: String, accessToken: String) {
//        self.clientId = clientId
//        self.accessToken = accessToken
//        self.session = URLSession(configuration: .default)
//    }
//
//    // MARK: - Helper
//    private func makeRequest(
//        endpoint: String,
//        method: String = "GET",
//        body: Data? = nil,
//        completion: @escaping (Result<[String: Any], Error>) -> Void
//    ) {
//        guard let url = URL(string: baseUrl + endpoint) else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
//            return
//        }
//        var request = URLRequest(url: url, timeoutInterval: timeout)
//        request.httpMethod = method
//        request.setValue(accessToken, forHTTPHeaderField: "access-token")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        if let body = body {
//            request.httpBody = body
//        }
//
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No data", code: 0)))
//                return
//            }
//            if let str = String(data: data, encoding: .utf8) {
//                print("Raw response: \(str)")
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data)
//                if let dict = json as? [String: Any] {
//                    completion(.success(dict))
//                } else if let array = json as? [[String: Any]] {
//                    // Wrap the array in a dictionary for consistency, or handle as needed
//                    completion(.success(["data": array]))
//                } else {
//                    completion(.failure(NSError(domain: "Invalid JSON", code: 0)))
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
//
//    // MARK: - Example Methods
//
//    public func getOrderList(completion: @escaping (Result<[String: Any], Error>) -> Void) {
//        makeRequest(endpoint: "/orders", completion: completion)
//    }
//
//    public func getOrderById(orderId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
//        makeRequest(endpoint: "/orders/\(orderId)", completion: completion)
//    }
//
//    public func placeOrder(
//        securityId: String,
//        exchangeSegment: String,
//        transactionType: String,
//        quantity: Int,
//        orderType: String,
//        productType: String,
//        price: Double,
//        triggerPrice: Double = 0,
//        disclosedQuantity: Int = 0,
//        afterMarketOrder: Bool = false,
//        validity: String = "DAY",
//        amoTime: String = "OPEN",
//        boProfitValue: Double? = nil,
//        boStopLossValue: Double? = nil,
//        tag: String? = nil,
//        completion: @escaping (Result<[String: Any], Error>) -> Void
//    ) {
//        var payload: [String: Any] = [
//            "dhanClientId": clientId,
//            "transactionType": transactionType.uppercased(),
//            "exchangeSegment": exchangeSegment.uppercased(),
//            "productType": productType.uppercased(),
//            "orderType": orderType.uppercased(),
//            "validity": validity.uppercased(),
//            "securityId": securityId,
//            "quantity": quantity,
//            "disclosedQuantity": disclosedQuantity,
//            "price": price,
//            "afterMarketOrder": afterMarketOrder
//        ]
//        if let boProfitValue = boProfitValue { payload["boProfitValue"] = boProfitValue }
//        if let boStopLossValue = boStopLossValue { payload["boStopLossValue"] = boStopLossValue }
//        if let tag = tag { payload["correlationId"] = tag }
//        if triggerPrice > 0 {
//            payload["triggerPrice"] = triggerPrice
//        } else {
//            payload["triggerPrice"] = 0.0
//        }
//        if afterMarketOrder {
//            payload["amoTime"] = amoTime
//        }
//        do {
//            let body = try JSONSerialization.data(withJSONObject: payload)
//            makeRequest(endpoint: "/orders", method: "POST", body: body, completion: completion)
//        } catch {
//            completion(.failure(error))
//        }
//    }
//
//    // Add more methods as needed, following the above pattern.
//}
// MARK: - DhanHQ.swift (full module)

// MARK: - DhanHQ.swift (modular, fully generic response)

import Foundation

public class DhanHQ {
    public let clientId: String
    public let accessToken: String
    private let baseURL = "https://api.dhan.co"
    private let timeout: TimeInterval = 60

    public static let NSE = "NSE_EQ"
    public static let BSE = "BSE_EQ"
    public static let INTRA = "INTRADAY"
    public static let CNC = "CNC"
    public static let LIMIT = "LIMIT"
    public static let MARKET = "MARKET"
    public static let BUY = "BUY"
    public static let SELL = "SELL"
    public static let DAY = "DAY"
    public static let IOC = "IOC"

    public init(clientId: String, accessToken: String) {
        self.clientId = clientId
        self.accessToken = accessToken
    }

    // MARK: - Generic reusable request with generic response
    private func request<T: Decodable>(endpoint: String, method: String = "GET", payload: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1))); return
        }
        var req = URLRequest(url: url, timeoutInterval: timeout)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue(accessToken, forHTTPHeaderField: "access-token")
        if let payload = payload {
            req.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        }
        URLSession.shared.dataTask(with: req) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -2))); return
            }
            if let str = String(data: data, encoding: .utf8) {
                          print("Raw response: \(str)")
                }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Orders module
    public func getOrderList<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/orders", completion: completion)
    }

    public func placeOrder<T: Decodable>(securityId: String, exchangeSegment: String, transactionType: String, quantity: Int, orderType: String, productType: String, price: Double, completion: @escaping (Result<T, Error>) -> Void) {
        let payload: [String: Any] = [
            "dhanClientId": clientId,
            "securityId": securityId,
            "exchangeSegment": exchangeSegment,
            "transactionType": transactionType,
            "quantity": quantity,
            "orderType": orderType,
            "productType": productType,
            "price": price,
            "validity": DhanHQ.DAY
        ]
        request(endpoint: "/orders", method: "POST", payload: payload, completion: completion)
    }

    public func cancelOrder<T: Decodable>(orderId: String, completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/orders/\(orderId)", method: "DELETE", completion: completion)
    }

    // MARK: - Funds module
    public func getFundLimits<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/fundlimit", completion: completion)
    }

    // MARK: - Positions module
    public func getPositions<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/positions", completion: completion)
    }

    // MARK: - Holdings module
    public func getHoldings<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/holdings", completion: completion)
    }

    // MARK: - Market data module
    public func getQuote<T: Decodable>(exchangeSegment: String, securityId: String, completion: @escaping (Result<T, Error>) -> Void) {
        let endpoint = "/market/quote?exchangeSegment=\(exchangeSegment)&securityId=\(securityId)"
        request(endpoint: endpoint, completion: completion)
    }

    // MARK: - Margin calculator module
    public func marginCalculator<T: Decodable>(payload: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/margin", method: "POST", payload: payload, completion: completion)
    }

    // MARK: - Option chain module
    public func getOptionChain<T: Decodable>(securityId: String, completion: @escaping (Result<T, Error>) -> Void) {
        request(endpoint: "/market/option-chain?securityId=\(securityId)", completion: completion)
    }
}
