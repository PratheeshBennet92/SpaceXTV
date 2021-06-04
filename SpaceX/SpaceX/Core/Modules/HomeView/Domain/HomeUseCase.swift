import Foundation
import RxCocoa
import RxSwift
import Apollo
class HomeUseCase: UseCaseProtocol {
  var dataRepository: DataRepositoryProtocol?
  var response =  BehaviorRelay<JSONEncodable?>(value: nil)
  let disposeBag = DisposeBag()
  func executeUseCase() {
    dataRepository = HomeDataRepository()
    addObserver()
    dataRepository?.executeFetchRequest()
  }
  func addObserver() {
    dataRepository?.response.filter({ each in
      each != nil
    }).subscribe(onNext: { [weak self] (response) in
      guard let self = self else {return}
      self.response.accept(response)
    }).disposed(by: disposeBag)
  }
  deinit {
    print("Deint HomeUseCase called")
  }
}
