import UIKit

/// Конформить этот протокол, когда ячейка грузится не из xib'a.
public protocol Reusable: class {
  static var reuseIdentifier: String { get }
}

/// Конформить этот протокол, когда ячейка грузится из xib.
public typealias NibReusable = Reusable & NibLoadable

public extension Reusable {
  /// По умолчанию используем имя класса в качестве идентификатора ячейки
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
