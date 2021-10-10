//
//  MReports.swift
//  HTrack
//
//  Created by Денис Щиголев on 10/9/21.
//

import FirebaseFirestore

enum MTypeReports: String, Codable, CaseIterable{
    case fake = "Фейк"
    case spam = "Спам"
    case offensiveContent = "Оскорбительный контент"
    case other = "Другое"
    
    static let description = "Жалоба"
    static let getReport = "Получил жалобу"
    
    init(from decoder: Decoder) throws {
        guard let rawValue = try? decoder.singleValueContainer().decode(String.self) else {
            self = .other
            return
        }
        
        self = MTypeReports(rawValue: rawValue) ?? .other
    }
    
    static var modelStringAllCases: [String] {
        allCases.map { report -> String in
            report.rawValue
        }
    }
}

struct MReports: Codable, Hashable{
    var reportUserID: String?
    var typeOfReports: MTypeReports?
    var text: String?
    
    init(reportUserID: String, typeOfReports: MTypeReports, text: String){
        self.reportUserID = reportUserID
        self.typeOfReports = typeOfReports
        self.text = text
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        reportUserID = try? container.decode(String.self, forKey: .reportUserID)
        typeOfReports = try? container.decode(MTypeReports.self, forKey: .typeOfReports)
        text = try? container.decode(String.self, forKey: .text)
    }
    
    init(json: [String: Any]) {
        if let reportUserID = json["reportUserID"] as? String {
            self.reportUserID = reportUserID
        } else {
            self.reportUserID = ""
        }
        if let typeOfReports = json["typeOfReports"] as? String {
            self.typeOfReports = MTypeReports(rawValue: typeOfReports) ?? MTypeReports.other
        } else {
            self.typeOfReports = MTypeReports.other
        }
        if let text = json["text"] as? String {
            self.text = text
        } else {
            self.text = ""
        }
    }
    
    init?(documentSnap: QueryDocumentSnapshot ) {
        let document = documentSnap.data()
        guard let reportUserID = document["reportUserID"] as? String else { return nil }
        guard let typeOfReports = document["typeOfReports"] as? String else { return nil }
        guard let text = document["text"] as? String else { return nil }
        
        self.reportUserID = reportUserID
        self.typeOfReports = MTypeReports(rawValue: typeOfReports) ?? MTypeReports.other
        self.text = text
    }
    
    enum CodingKeys: String, CodingKey  {
        case reportUserID
        case typeOfReports
        case text
    }
}
