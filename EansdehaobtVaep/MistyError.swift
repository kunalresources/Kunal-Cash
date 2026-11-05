import Foundation
import Moya

enum MistyError: Error {
    case trailHTTP(Int)
    case mistBusiness(code: Int, fogMsg: String?)
    case oakDecode(Error)
    case moya(MoyaError)

    private static let reedCommonLine = "The system is busy right now. Please try again in 2 minutes."

    var fogReedLine: String {
        switch self {
        case .trailHTTP:
            return Self.reedCommonLine
        case let .mistBusiness(_, fogMsg):
            let t = fogMsg?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return t.isEmpty ? "Request failed" : t
        case .oakDecode:
            return Self.reedCommonLine
        case .moya:
            return Self.reedCommonLine
        }
    }
}
