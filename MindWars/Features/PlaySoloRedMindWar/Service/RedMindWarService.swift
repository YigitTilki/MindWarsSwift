import Foundation
import FirebaseFirestore

// MARK: - Red Mind War Service
struct RedMindWarService {
    
    func increaseAnswerCount(
        questionId: String,
        part: String,
        questionType: String,
        field: String
    ) async {
        let path: () throws -> DocumentReference = {
            FirestoreService.db.collection("questions")
                .document("1")
                .collection(questionType)
                .document("parts")
                .collection(part)
                .document(questionId)
        }
        
        await _ = FirestoreService.execute(
            request: "Update \(field) for \(questionId)",
            operation: {
                try await FirestoreService.update(
                    path: path,
                    data: [field: FieldValue.increment(Int64(1))]
                )
                return "\(field) successfully increased"
            }
        )
    }
    
    func getExplains() async -> RedQuestionSectionExplainModel? {
        await FirestoreService.execute(
            request: "Fetch section explanations",
            operation: {
                let path: () throws -> DocumentReference = {
                    FirestoreService.db.collection("sectionDescriptions").document("1")
                }
                return try await FirestoreService.fetch(
                    path: path,
                    responseType: RedQuestionSectionExplainModel.self
                )
            }
        )
    }
    
    func getQuestions<T: Decodable>(
        part: String,
        questionType: String,
        responseType: T.Type
    ) async -> [T] {
        await FirestoreService.execute(
            request: "Fetch \(questionType) questions for part \(part)",
            operation: {
                let path: () throws -> Query = {
                    FirestoreService.db.collection("questions")
                        .document("1")
                        .collection(questionType)
                        .document("parts")
                        .collection(part)
                        
                }
                return try await FirestoreService.fetchCollection(
                    path: path,
                    responseType: [T].self
                )
            }
        ) ?? []
    }
    
    
}


