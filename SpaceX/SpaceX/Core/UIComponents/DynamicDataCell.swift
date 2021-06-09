import Foundation
protocol DynamicDataCell {
  associatedtype DataType
  func configure(_ dataType: DataType?, imageDownload: ((Data) -> Void)?)
  var buttonPressedAction: ((DataType?) -> Void)? { get set }
}
