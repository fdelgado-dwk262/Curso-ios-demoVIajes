//
//  ContentView.swift
//  Curso-ios-demoVIajes
//
//  Created by Equipo 9 on 29/1/26.
//

import SwiftUI

struct VistaDemoViajes: View {
    // variable de stado
    @State private var nombreUsuario: String = ""

    // variable de estado en lista de destinos Hardcode

    @State private var destinos: [Destino] = [
        Destino(
            nombre: "Madrid",
            icono: "building.columns.fill",
            descripcion: "Destino de moda",
            color: .red
        ),
        Destino(
            nombre: "Barcelona",
            icono: "cloud.rain.fill",
            descripcion: "Destino de playa",
            color: .blue
        ),
        Destino(
            nombre: "Valencia",
            icono: "cloud.sun.fill",
            descripcion: "Destino de cultura",
            color: .yellow
        ),
    ]

    var body: some View {
        VStack {
            Text("📍 Demo de viajes  ✈️📍")
        }
        .padding()

        TabView {
            Text("texto temporal")
                .tabItem {
                    Label("Inicio", systemImage: "map")
                }
            NavigationStack {
                VistaPerfilUsuario(nombreUsuario: $nombreUsuario)
            }
            .tabItem {
                Label("Mi perfil", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    VistaDemoViajes()
}
