//
//  HomeViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 21.12.2024.
//

import FirebaseFirestore
import Combine

@MainActor
class HomeViewModel: AddRedQuestionsBaseViewModel,ObservableObject {

    @Published var message: MessageModel?
    
    
}
