import Foundation

enum SetupStep: Int, CaseIterable, Identifiable {
    case welcome = 0
    case java
    case akia
    case bdp
    case lucaProxy
    case complete

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .welcome:   return "Hoş Geldiniz"
        case .java:      return "Java Kurulumu"
        case .akia:      return "Akia Sürücüsü"
        case .bdp:       return "eBeyanname İndir"
        case .lucaProxy: return "Luca Proxy"
        case .complete:  return "Tamamlandı"
        }
    }

    var systemImage: String {
        switch self {
        case .welcome:   return "hand.wave.fill"
        case .java:      return "cup.and.saucer.fill"
        case .akia:      return "creditcard.fill"
        case .bdp:       return "arrow.down.circle.fill"
        case .lucaProxy: return "network"
        case .complete:  return "checkmark.seal.fill"
        }
    }

    var next: SetupStep? {
        SetupStep(rawValue: rawValue + 1)
    }
}
