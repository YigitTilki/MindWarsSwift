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
            FirebaseService.db.collection("questions")
                .document("1")
                .collection(questionType)
                .document("parts")
                .collection(part)
                .document(questionId)
        }
        
        await _ = FirebaseService.execute(
            request: "Update \(field) for \(questionId)",
            operation: {
                try await FirebaseService.update(
                    path: path,
                    data: [field: FieldValue.increment(Int64(1))]
                )
                return "\(field) successfully increased"
            }
        )
    }
    
    func getExplains() async -> Result<RedQuestionSectionExplainModel?, Error> {
        await FirebaseService.execute(
            request: "Fetch section explanations",
            operation: {
                let path: () throws -> DocumentReference = {
                    FirebaseService.db.collection("sectionDescriptions").document("1")
                }
                return try await FirebaseService.fetch(
                    path: path,
                    responseType: RedQuestionSectionExplainModel.self
                )
            }
        )
    }
    
    func getRedMindWarInfo() async -> Result<RedMindWarInfoModel?, Error> {
        await FirebaseService.execute(request: "Fetch RedMindWarInfo", operation: {
            let path: () throws -> DocumentReference = {
                FirebaseService.db.collection("questions").document("1")
            }
            return try await FirebaseService.fetch(
                path: path, responseType: RedMindWarInfoModel.self
                )
            
            }
        )
    }
    
    func getQuestions<T: Decodable>(
        part: String,
        questionType: String,
        responseType: T.Type
    ) async -> Result<[T], Error>{
        await FirebaseService.execute(
            request: "Fetch \(questionType) questions for part \(part)",
            operation: {
                let path: () throws -> Query = {
                    FirebaseService.db.collection("questions")
                        .document("1")
                        .collection(questionType)
                        .document("parts")
                        .collection(part)
                    
                }
                return try await FirebaseService.fetchCollection(
                    path: path,
                    responseType: [T].self
                )
            }
        ) ?? .failure(NSError(domain: "", code: 0, userInfo: nil))
    }
    
    
}


