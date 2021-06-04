import Foundation
import RxCocoa
import RxSwift
import Apollo
class HomeDataRepository: DataRepositoryProtocol {
  var remoteStore: RemoteStoreProtocol?
  var response =  BehaviorRelay<JSONEncodable?>(value: nil)
  let disposeBag = DisposeBag()
  func executeFetchRequest() {
    remoteStore = HomeRemoteStore()
    addObserver()
    remoteStore?.connectRemote()
  }
  func addObserver() {
    remoteStore?.responseObserver?.subscribe(onNext: { [weak self] result in
      guard let self = self else {return}
      self.response.accept(result)
    }).disposed(by: disposeBag)
  }
  deinit {
    print("Denit HomeDataRepository called")
  }
}
