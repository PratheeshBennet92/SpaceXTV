import Foundation
enum PayloadType: String {
  case CrewDragon = "Crew Dragon"
  case Satellite = "Satellite"
  case CargoDragon = "Dragon 1.1"
  var value: String? {
  return String(describing: self)
  }
}
