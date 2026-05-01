import Foundation

enum ComponentStatus: Equatable {
    case unchecked
    case checking
    case installed
    case notInstalled
    case installing
    case downloading(Double)
    case failed(String)

    var isReady: Bool { self == .installed }

    var statusText: String {
        switch self {
        case .unchecked:              return "Kontrol edilmedi"
        case .checking:               return "Kontrol ediliyor..."
        case .installed:              return "Kurulu"
        case .notInstalled:           return "Kurulu değil"
        case .installing:             return "Kuruluyor..."
        case .downloading(let p):     return "İndiriliyor... %\(Int(p * 100))"
        case .failed(let msg):        return "Hata: \(msg)"
        }
    }

    var symbolName: String {
        switch self {
        case .installed:              return "checkmark.circle.fill"
        case .notInstalled:           return "xmark.circle.fill"
        case .failed:                 return "exclamationmark.circle.fill"
        case .checking,
             .installing,
             .downloading:            return "arrow.clockwise.circle.fill"
        case .unchecked:              return "circle"
        }
    }
}
