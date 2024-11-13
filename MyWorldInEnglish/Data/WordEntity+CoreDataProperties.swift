import Foundation
import CoreData

extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var englishWord: String?
    @NSManaged public var wordType: String?
    @NSManaged public var level: String?
    @NSManaged public var turkishTranslation: String?
    @NSManaged public var exampleSentenceEn: String?
    @NSManaged public var exampleSentenceTR: String?
    @NSManaged public var isHidden: Bool
}

