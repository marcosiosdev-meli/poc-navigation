//
//  FullFile.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 11/11/22.
//

import SwiftUI


/*
  🇧🇷 Estrutura concretas/Solidas para criar uma View (section) em SwiftUI
 */


public protocol DataView {
    var type: String  { get set } // Bricks type
    var data: Codable  { get set }
    var event: Event  { get set }
    
    /// 🇧🇷 retorn a view e o event para ViewModel poder fazer a regra.
    func buildView(eventHandle: ((_ event: Event?) -> Void)?) -> AnyView
}

// Eventos que vem na resposta de cada bricks.
// Eventos que a ViewModel precisa para poder Tracking, Storage, Navigation y Otros.
public protocol Event {
    var type: EventType { get set }
    var external: String? { get set }
    var mode: String? { get set }
    var url: String? { get set }
    var index: Int? { get set }
}

// Tipo dos Eventos que vem na resposta de cada bricks.
public enum EventType: String, Codable {
    case deeplink = "deeplink"
    case goToTabbarIos = "go_to_tabbar_ios"
    case logoutMp = "logout_mp"
    case other
}



/**
 
 Abaixo um Exemplo de Implementação de Header.
 
 */

extension View {
    func anyView() -> AnyView {
        return AnyView(self)
    }
}

struct HeaderDataView: DataView {
    var type: String
    var data: Codable
    var event: Event
    
    func buildView(eventHandle: ((_ event: Event?) -> Void)? = nil ) -> AnyView  {
        
        guard let headerEvent = event as? HeaderEvent,
              let responseData = data as? HeaderDataResponse else  {
            return EmptyView().anyView()
        }
        
        let dtoView = transformDataView(headerResponse: responseData)
        
        return HeaderView(dtoView: dtoView) {
            eventHandle?(headerEvent)
        }.anyView()
    }

    private func transformDataView(headerResponse data: HeaderDataResponse) -> HeaderDTOView {
        return HeaderDTOView(
            name: data.name ?? "",
            subtitle: "Subtitulo",
            avatar: "👨🏻")
    }
}

struct HeaderView: View {
    
    var dtoView: HeaderDTOView
    var tapped: (() -> Void)?
    
    
    var body: some View {
        Text(dtoView.name).onTapGesture {
            tapped?()
        }
    }
}

struct HeaderDTOView {
    var name: String
    var subtitle: String
    var avatar: String
}

struct HeaderCodable: Codable {
    var name: String
    var event: HeaderEvent
}

struct HeaderEvent: Codable, Event {
    var type: EventType
    var external: String?
    var mode: String?
    var url: String?
    var index: Int?
}
struct HeaderDataResponse: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init() {
        name = "No tenes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
    }
}


struct ContentViewState {
    var dataViews: [DataView]
}

class ContentViewModel: ObservableObject {
    @Published
    var state = ContentViewState(dataViews: [])
    
    func appear() {
        // exemplo de ir no Interactor e voltar com os dataViews regristrados.
        state = ContentViewState(dataViews: [
            HeaderDataView(
                type: "header-type",
                data: HeaderDataResponse(),
                event: HeaderEvent(type: .deeplink, external: "true", mode: "push", url: "mercadopago://sample/header", index: nil)
            )
        ])
    }
    
    func event(perform event: Event) {
        if let eventUnwrapper = event as? HeaderEvent {
            print("Vai pro deeplink == \(eventUnwrapper.url)")
        }
        //DO Tracking, Navigation, Storage or Qualquer coisa de regras de apresentações.
    }
}


//
//struct PocContentView: View {
//
//    @StateObject
//    var viewModel = ContentViewModel()
//
//    var body: some View {
//        VStack {
//            ForEach(viewModel.state.dataViews, id: \.type) { dataView in
//                dataView.buildView(eventHandle: viewModel.event(perform:))
//            }
//        }
//    }
//}
