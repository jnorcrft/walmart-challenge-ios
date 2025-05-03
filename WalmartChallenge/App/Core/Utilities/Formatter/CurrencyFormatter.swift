import Foundation

struct CurrencyFormatter {
  private static let clpFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "es_CL")
    return formatter
  }()

  static func formatToCLP(_ amount: Decimal) -> String {
    "\(clpFormatter.string(from: amount as NSDecimalNumber)!) CLP"
  }
}
