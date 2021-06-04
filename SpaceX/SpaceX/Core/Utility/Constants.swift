import Foundation
import UIKit
struct Constants {
  static let emptyString = ""
  static let appName = "TV Lineup"
  static let appBundleId = "com.tvlinup"
  struct NotificationName {
    static let refresh = "refresh"
  }
  struct DateGrid {
    static let dayFontSize: CGFloat = 20
    static let dateFontSize: CGFloat = 17
    static let dateGridHeight: CGFloat = 70
    static let dateGridTopWNotch: CGFloat = 40
    static let dateGridTopWONotch: CGFloat = 20
    static let itemWidth: CGFloat = 100
    static let itemHeight: CGFloat = 75
  }
  struct ListView {
    static let searchBarPlaceHolder = "Name/genre/network"
    static let searchBarHeight: CGFloat = 40
    static let searchBarTopWNotch: CGFloat = 110
    static let searchBarTopWONotch: CGFloat = 100
    static let listViewTop: CGFloat = 150
  }
  struct Network {
    static let baseUrl = "http://api.tvmaze.com/"
    static let itemPath = "schedule"
    static let defaultTimeOut: Double = 120
    static let sessionId = "com.covidfighter"
    static let error = "error"
    static let failure = "Failure"
  }
  struct Alert {
    static let downloadErrorTitle = "Couldn't get info"
    static let downloadErrorMsg = "Technical error occured. Please check your connectivity"
  }
  struct TabBarItems {
    static let tab1Title = "Schedule"
    static let tab2Title = "Contact"
  }
  static var hasTopNotch: Bool {
      if #available(iOS 11.0, *) {
          return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
      }
      return false
  }
}
