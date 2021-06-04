import Foundation
import RxSwift
import RxCocoa
import Apollo
protocol Viewable {
  associatedtype ViewModel
  associatedtype Coordinator
  associatedtype CoordinatorDelegate
  var coordinatorDelegate: CoordinatorDelegate? { get set }
  var coordinator: Coordinator? { get set }
  var viewModel: ViewModel? { get set }
  func setupViewModel()
  func addObserver()
}
protocol UIModel: Codable {
  var model: String? {get set}
}
protocol ViewModelProtocol {
  var outputModel: [JSONEncodable]? {get set}
  func startViewModel()
  var response: BehaviorRelay<[JSONEncodable]?>{get set}
  var error: BehaviorRelay<Codable?>{get set}
}
protocol UseCaseProtocol {
  var response: BehaviorRelay<JSONEncodable?> {get set}
  var dataRepository: DataRepositoryProtocol? { get set }
  func executeUseCase()
  func addObserver()
}
protocol DataRepositoryProtocol {
  var response: BehaviorRelay<JSONEncodable?> {get set}
  var remoteStore: RemoteStoreProtocol? { get set }
  func executeFetchRequest()
  func addObserver()
}
protocol LocalStoreProtocol {
  
}
protocol RemoteStoreProtocol {
  var responseObserver: PublishSubject<JSONEncodable?>? { get set }
  func connectRemote()
}
