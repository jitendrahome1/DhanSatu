import Foundation
import Combine

class DhanHQViewModel: ObservableObject {
    @Published var orderList: [String: Any]? = nil
    @Published var errorMessage: String? = nil

//    private let api = DhanHQ(clientId: "1102344139", accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJkaGFuIiwicGFydG5lcklkIjoiIiwiZXhwIjoxNzUzMjkzNTM2LCJ0b2tlbkNvbnN1bWVyVHlwZSI6IlNFTEYiLCJ3ZWJob29rVXJsIjoiIiwiZGhhbkNsaWVudElkIjoiMTEwMjM0NDEzOSJ9.ivY2RJUyaY_j6JsRUMnpwO2WAja5qOcs-0Aimw6n1uVBERS8vI8dyvoQC6ZyU8vgycJx-ARGqQdyjkW1S6Im_Q")

//    func fetchOrderList() {
//        api.getOrderList { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data):
//                    self?.orderList = data
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
}
