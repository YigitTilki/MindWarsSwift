//
//  AddRedQuestionsBaseViewModel.swift
//  MindWars
//
//  Created by Yiğit Tilki on 8.01.2025.
//

import FirebaseFirestore
import Foundation

@MainActor
class AddRedQuestionsBaseViewModel: BaseViewModel {
    let db = Firestore.firestore()
    @Published var question1: String = ""
    @Published var question2: String = ""
    @Published var answerDescription1: String = ""
    @Published var answerDescription2: String = ""
    @Published var selectedPart: QuestionPart = .none
    @Published var difficulty: QuestionDifficulty = .medium
    @Published var language: Languages = .tr
    @Published var type: QuestionType = .general
    @Published var time: QuestionTime = .thirtySec
    @Published var lengthOfPart: String = ""
    @Published var isImageQuestion: Bool = false
    @Published var isImagePickerPresented = false
    @Published var selectedImage: UIImage?

    func getPartLength(sectionId: Int) async {
        do {
            let section = RedQuestionSectionEnum(rawValue: sectionId) ?? .none

            let partLength = try await db.collection("questions")
                .document("1")
                .collection(section?.collectionName ?? "")
                .document("parts")
                .collection(selectedPart.rawValue)
                .getDocuments()
                .count

            lengthOfPart = String(partLength)

        } catch {
            print("Error getPartLength: \(error)")
            alertItem = AlertContext.unexpectedError
        }
    }
}
