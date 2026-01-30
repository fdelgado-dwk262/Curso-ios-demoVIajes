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
    @State private var tabSeleccionada: Int = 0

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
            color: .yellow,
            esFavorito: true,
            puntuacion: 3
        ),
    ]

    var body: some View {
        VStack {
            Text("📍 Demo de viajes 📍")
        }
        .padding()

        TabView(selection: $tabSeleccionada) {
            // vista 01 listado de destino con su tab
            VistaListaDestinosLocal(
                destinos: $destinos,
                nombreUsuario: $nombreUsuario,
                tabSeleccionada: $tabSeleccionada
            )
            .tabItem {
                Label("Inicio", systemImage: "map")
            }
            .tag(0)

            NavigationStack {
                VistaPerfilUsuario(nombreUsuario: $nombreUsuario)
            }
            .tabItem {
                Label("Mi perfil", systemImage: "person.circle")
            }
            .tag(1)
            
            NavigationStack {
                GyroscopeView()
            }
            .tabItem {
                Label("Demo", systemImage: "person.circle")
            }
            .tag(2)
        }
    }
}

// por el momento en local a futuro lo pasaremos a una vista en un fichero aparte
struct VistaListaDestinosLocal: View {

    @Binding var destinos: [Destino]
    @Binding var nombreUsuario: String
    @Binding var tabSeleccionada: Int

    var body: some View {

        NavigationStack {
            List {
                // Encabezado
                Section {
                    
                    // antes navegaba a la vista pero las tab no se actualizaban
                    // NavigationLink(
                    //  destination: VistaPerfilUsuario(
                    //           nombreUsuario: $nombreUsuario
                    //      )
                    // ) {
                    // ahora al cambiar la vista cambia la tabs inferiores
                    
                    Button {
                        tabSeleccionada = 1
                    } label: {

                        HStack {
                            (Text("Hola, ").foregroundStyle(.gray)
                                + Text(
                                    nombreUsuario.isEmpty
                                        ? "Explorador/a" : " \(nombreUsuario)"
                                ).foregroundStyle(.primary).fontWeight(.bold))
                                .font(Font.title2)

                            Spacer()

                            Image(systemName: "pencil.circle.fill")
                                .foregroundStyle(.green)
                        }
                        .padding(.vertical, 6)
                    }

                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                // Destinos
                Section("Tus destinos") {
                    ForEach($destinos) { $destino in
                        //                        NavigationLink(destination: Text("\(destino.nombre)")){
                        // llamamos a la vista y como todos los ddatos estan en el contsto global funcion correctamente
                        NavigationLink(
                            destination: VistaDetalleDestino(destino: $destino)
                        ) {
                            HStack(spacing: 15) {
                                ZStack {
                                    Circle()
                                        .fill(destino.color)
                                        .frame(width: 50)
                                    Image(systemName: destino.icono)
                                        .foregroundStyle(Color.white)

                                }

                                VStack(alignment: .leading) {
                                    Text(destino.nombre)
                                        .font(Font.headline)

                                    if destino.puntuacion > 0 {
                                        HStack(spacing: 2) {

                                            // generador de vistas
                                            ForEach(
                                                0..<destino.puntuacion,
                                                id: \.self
                                            ) { _ in
                                                Image(systemName: "star.fill")
                                                    .foregroundStyle(.yellow)
                                                    .font(.caption2)
                                            }
                                        }
                                    } else {
                                        HStack(spacing: 2) {
                                            Text("Sin Valoración").font(
                                                Font.caption2
                                            ).foregroundStyle(
                                                .gray.opacity(0.7)
                                            )
                                        }
                                    }
                                }

                                Spacer()

                                if destino.esFavorito {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                } else {
                                    Image(systemName: "heart").foregroundStyle(
                                        .gray
                                    ).opacity(0.5)
                                }
                            }
                        }
                    }
                }
                //                .listRowBackground(Color.clear)
                //                .listRowSeparator(.hidden)

            }
            .navigationTitle("Destinos")
            .navigationBarTitleDisplayMode(.automatic)
        }

    }
}

#Preview {
    VistaDemoViajes()
}
