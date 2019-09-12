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
class HomeVM: ObservableObject {
    let didChange = PassthroughSubject<HomeVM,Never>()
    var Albums = [Album]() {
        didSet {
            didChange.send(self)
        }
    }
    var Tracks = [Track]() {
        didSet {
            didChange.send(self)
        }
    }
    var didError = ErrorType(error: "Error") {
        didSet {
            didChange.send(self)
        }
    }
    init() {
        requestData()
    }
    func requestData() {
        GSWNwtwork.requestData(url: "dcd86ebedb5e519fd7b09b79dd4e4558/raw/b7505a54339f965413f5d9feb05b67fb7d0e464e/MvvmExampleApi.json", method: .get, parameters: nil, completion: { (result) in
            switch result {
            case .success(let returnJson) :
                self.Albums = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                self.Tracks = returnJson["Tracks"].arrayValue.compactMap {return Track(data: try! $0.rawData())}
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.didError = ErrorType(error: "ConnectionError")
                case .authorizationError(let errorJson):
                    self.didError = ErrorType(error: "authorizationError")
                case .unknownError:
                    self.didError = ErrorType(error: "unknownError")
                default:break
                    //    self.viewModel?.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
    
}

