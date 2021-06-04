import Foundation
import RxSwift
import Apollo
class HomeRemoteStore: RemoteStoreProtocol {
  var responseObserver: PublishSubject<JSONEncodable?>? = PublishSubject<JSONEncodable?>()
  func connectRemote() {
    Network.shared.apollo.fetch(query: LaunchlistQuery()) { result in
      switch result {
      case .success(let graphQLResult):
        self.responseObserver?.onNext(graphQLResult.data?.launchesPast)
      case .failure(let error):
        print("Failure! Error: \(error)")
      }
    }
  }
}
