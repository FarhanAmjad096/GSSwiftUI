//
//  ViewModel.swift
//  GSWSwiftUI
//
//  Created by Muhammad Irfan Zafar on 11/09/2019.
//  Copyright © 2019 Muhammad Irfan Zafar. All rights reserved.
//

import SwiftUI
import Combine
class ErrorType: Identifiable {
    let id = UUID()
    let error: String
    init(error: String ) {
        self.error = error
    }
    
    var title: String {
        return self.error
    }
}
enum ViewState {
    case error
    case loading
    case dataAvail
}
class HomeVM: ObservableObject {
    
    //Mark: - LifeCycle
    init() {
        requestData()
    }
    //Mark: - Properties
    let didChange = PassthroughSubject<HomeVM,Never>()
    @Published var viewState: ViewState = .loading
    var isLoading: Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    var Albums: [Album] = load("Album.json") {
        didSet {
            self.didChange.send(self)
        }
    }
    var Tracks: [Track] = load("Track.json") {
        didSet {
            self.didChange.send(self)
        }
    }
    var didError = ErrorType(error: "Error") {
        didSet {
            self.didChange.send(self)
        }
    }
    deinit {
        print("ViewModel deInit")
    }
    func requestData() {
        DispatchQueue.main.async {
            self.viewState = .loading
            //self.isLoading = true
        }
        GSWNwtwork.requestData(url: "dcd86ebedb5e519fd7b09b79dd4e4558/raw/b7505a54339f965413f5d9feb05b67fb7d0e464e/MvvmExampleApi.json", method: .get, parameters: nil, completion: { (result) in
            switch result {
            case .success(let returnJson) :
                self.Albums = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                self.Tracks = returnJson["Tracks"].arrayValue.compactMap {return Track(data: try! $0.rawData())}
               // let value = returnJson["Tracks"].arrayObject?[""]
                DispatchQueue.main.async {
                    self.viewState = .dataAvail
                    self.isLoading = false
                }
            case .failure(let failure) :
                DispatchQueue.main.async {
                    self.viewState = .error
                    self.isLoading = false
                }
                switch failure {
                case .connectionError:
                    self.didError = ErrorType(error: "ConnectionError")
                case .authorizationError(let errorJson):
                    self.didError = ErrorType(error: errorJson.description)
                case .unknownError:
                    self.didError = ErrorType(error: "unknownError")
                default:break
                    //    self.viewModel?.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
}


// Mark:- Load Json
func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
