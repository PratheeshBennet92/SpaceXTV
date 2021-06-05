import Foundation
import RxSwift
import RxCocoa
import Apollo
class HomeViewModel: ViewModelProtocol {
  var useCase: UseCaseProtocol?
  var outputModel: [JSONEncodable]?
  let disposeBag = DisposeBag()
  var response = BehaviorRelay<JSONEncodable?>(value: nil)
  var error = BehaviorRelay<Codable?>(value: nil)
  func startViewModel() {
    useCase = HomeUseCase()
    addObserver()
    useCase?.executeUseCase()
  }
  func addObserver() {
    useCase?.response.filter({ responseObj in
      responseObj != nil
    }).subscribe(onNext: { [weak self] (responseObj) in
      guard let self = self else {return}
      self.response.accept(responseObj)
    }).disposed(by: disposeBag)
  }
}
