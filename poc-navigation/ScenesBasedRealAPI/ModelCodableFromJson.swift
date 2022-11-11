//
//  ModelCodableFromJson.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 11/11/22.
//

import Foundation

// MARK: - NavigationSectionResponse
struct NavigationSectionResponse: Codable {
    let id: ID
    let type: String
    let data: NavigationSectionResponseData
}

// MARK: - NavigationSectionResponseData
struct NavigationSectionResponseData: Codable {
    let pageID: ID
    let events: [PurpleEvent]

    enum CodingKeys: String, CodingKey {
        case pageID = "page_id"
        case events
    }
}

// MARK: - PurpleEvent
struct PurpleEvent: Codable {
    let type: String
    let data: PurpleData
    let tracking: Tracking
}

// MARK: - PurpleData
struct PurpleData: Codable {
    let bricks: [DataBrick]
}

// MARK: - DataBrick {
//    Aqui fazer igual no Feed Native,
//    Colocar um type em Enum.Case e na hora de fazer a conversão , faz com os internos e deixa os tipos para os externos.
//    Os externos irão cadastrar de alguma forma o (tipo, dados do parse e a view).
//
//}
struct DataBrick: Codable {
    let id, uiType: String
    let bricks: [PurpleBrick]

    enum CodingKeys: String, CodingKey {
        case id
        case uiType = "ui_type"
        case bricks
    }
}

// MARK: - PurpleBrick
struct PurpleBrick: Codable {
    let id, uiType: String
    let data: StickyData
    let bricks: [FluffyBrick]?

    enum CodingKeys: String, CodingKey {
        case id
        case uiType = "ui_type"
        case data, bricks
    }
}

// MARK: - FluffyBrick
struct FluffyBrick: Codable {
    let id, uiType: String
    let data: FluffyData?

    enum CodingKeys: String, CodingKey {
        case id
        case uiType = "ui_type"
        case data
    }
}

// MARK: - FluffyData
struct FluffyData: Codable {
    let avatar: Avatar?
    let events: [FluffyEvent]?
    let pageID: ID?
    let accessibilityText: String?
    let iconRight: Icon?
    let title: TitleUnion?
    let backgroundColor: String?
    let icon, iconArrow: Icon?
    let badge: Badge?
    let color: String?

    enum CodingKeys: String, CodingKey {
        case avatar, events
        case pageID = "page_id"
        case accessibilityText = "accessibility_text"
        case iconRight = "icon_right"
        case title
        case backgroundColor = "background_color"
        case icon
        case iconArrow = "icon_arrow"
        case badge, color
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let loyalty: Loyalty
}

// MARK: - Loyalty
struct Loyalty: Codable {
    let percentageLevel: Double
    let empty, fill, colorLevel: String
    let level: Int

    enum CodingKeys: String, CodingKey {
        case percentageLevel = "percentage_level"
        case empty, fill
        case colorLevel = "color_level"
        case level
    }
}

// MARK: - Badge
struct Badge: Codable {
    let textProvider: String?
    let id, backgroundColor, textColor, text: String

    enum CodingKeys: String, CodingKey {
        case textProvider = "text_provider"
        case id
        case backgroundColor = "background_color"
        case textColor = "text_color"
        case text
    }
}

// MARK: - FluffyEvent
struct FluffyEvent: Codable {
    let id: String
    let data: TentacledData?
    let type: TypeEnum
}

// MARK: - TentacledData
struct TentacledData: Codable {
    let external: String?
    let mode: String?
    let url: String?
    let index: Int?
}

enum TypeEnum: String, Codable {
    case deeplink = "deeplink"
    case goToTabbarIos = "go_to_tabbar_ios"
    case logoutMp = "logout_mp"
}

// MARK: - Icon
struct Icon: Codable {
    let name: String
}

enum ID: String, Codable {
    case navigationMenuMp = "navigation_menu_mp"
}

enum TitleUnion: Codable {
    case string(String)
    case titleClass(TitleClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(TitleClass.self) {
            self = .titleClass(x)
            return
        }
        throw DecodingError.typeMismatch(TitleUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TitleUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .titleClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - TitleClass
struct TitleClass: Codable {
    let color: String?
    let text: String
}

// MARK: - StickyData
struct StickyData: Codable {
    let textStyle: String?
    let separator: Separator?

    enum CodingKeys: String, CodingKey {
        case textStyle = "text_style"
        case separator
    }
}

// MARK: - Separator
struct Separator: Codable {
    let disabled: String
}

// MARK: - Tracking
struct Tracking: Codable {
    let tracks: [Track]
}

// MARK: - Track
struct Track: Codable {
    let provider: String
}
