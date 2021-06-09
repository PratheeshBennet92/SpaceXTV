import Foundation
import RxCocoa
import RxSwift
import Apollo
class HomeUseCase: UseCaseProtocol {
  var dataRepository: DataRepositoryProtocol?
  var response =  BehaviorRelay<JSONEncodable?>(value: nil)
  let disposeBag = DisposeBag()
  var payloadType: PayloadType?
  func executeUseCase() {
    dataRepository = HomeDataRepository()
    addObserver()
    dataRepository?.executeFetchRequest()
  }
  func addObserver() {
    dataRepository?.response.filter({ responseObj in
      responseObj != nil
    }).subscribe(onNext: { [weak self] (response) in
      guard let self = self else {return}
      var result: JSONEncodable?
      result = (response as? [JSONEncodable])?.filter({ each in
          (each as? LaunchlistQuery.Data.LaunchesPast)?.rocket?.secondStage?.payloads?.first??.payloadType == self.payloadType?.rawValue
        })
      self.response.accept(result)
    }).disposed(by: disposeBag)
  }
  deinit {
    print("Deint HomeUseCase called")
  }
}
