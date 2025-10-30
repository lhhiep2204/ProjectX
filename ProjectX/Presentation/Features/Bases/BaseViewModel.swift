//
//  BaseViewModel.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine
import SwiftUI

@Observable
class BaseViewModel {
    var subscriptions = Set<AnyCancellable>()
}
