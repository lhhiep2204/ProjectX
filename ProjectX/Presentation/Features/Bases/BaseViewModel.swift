//
//  BaseViewModel.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine

class BaseViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
}
