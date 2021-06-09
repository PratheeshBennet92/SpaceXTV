import Foundation
import RxSwift
import RxCocoa
import Apollo
class DetailViewModel: ViewModelProtocol {
  var outputModel: [JSONEncodable]? = []
  var useCase: UseCaseProtocol?
  let disposeBag = DisposeBag()
  var response = BehaviorRelay<JSONEncodable?>(value: nil)
  var error = BehaviorRelay<Codable?>(value: nil)
  init(arrImages: [String?]) {
    arrImages.forEach { eachImage in
      outputModel?.append(ImageModel(jsonValue: eachImage as JSONValue, image: eachImage))
    }
  }
  func startViewModel() {
    self.response.accept(outputModel)
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
