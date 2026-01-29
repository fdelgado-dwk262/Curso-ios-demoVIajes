//
//  VistaDetalleDestino.swift
//  Curso-ios-demoVIajes
//
//  Created by Equipo 9 on 29/1/26.
//

import SwiftUI

struct VistaDetalleDestino: View {

    @Binding var destino: Destino
    @State private var escalaCorazon: CGFloat = 1.0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .bottomTrailing) {

                    // definidmos un "fondo"
                    Rectangle()
                        .fill(destino.color.gradient)
                        .frame(height: 200)

                    // definimos un boton
                    // MARK: boton Favorito
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            destino.esFavorito.toggle()
                        }
                        
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration:0)) {
                            escalaCorazon = 1.4
                        }
                        
                        // para ver la animacion hay que ponerle un delay
                        // aqui se habla de los hilos , ejecuciones concurrentes
                        // con el dispatch .- es una ejecuacion no lineal
                        // el hilo principal es el unico que tiene permiso para modificar vistas
                        // en una vista secuandaria peta la app por permisos en los hilos secundarios
                        //El dispach lo que hacemos en meter este código en el hilo proncipla
                        // y sea asincrona y no se bloque la app, y ademas despues de un periodo de tiempo
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration:0)) {
                                escalaCorazon = 1.0
                            }
                        }
                        
                    } label: {
                        Image(
                            systemName: destino.esFavorito
                                ? "heart.fill" : "heart"
                        )
                        .font(.largeTitle)
                        .foregroundStyle(destino.esFavorito ? .red : .white)
                        // animacion
                        .scaleEffect(escalaCorazon)
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(.circle)
                        .padding()
                    }
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text(destino.nombre)
                        .font(.largeTitle)
                        .bold()

                    Text(destino.descripcion)
                        .font(.body.bold())

                    Divider()

                    VistaPuntuacion(
                        puntuacion: $destino.puntuacion,
                        descripcion: $destino.descripcion
                    )
                }
                .padding()
            }
        }
    }
}

// Vista secundaria que habrá que exportar a un archivo en el futuro

struct VistaPuntuacion: View {

    @Binding var puntuacion: Int
    @Binding var descripcion: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tu valoración")
                    .font(.headline)

                Spacer()

                if puntuacion > 0 {
                    Button("borrar") {
                        puntuacion = 0
                    }
                    .font(.caption)
                    .foregroundColor(.red)

                }
            }
            
            // MARK: Estrellas puntuación
            HStack {
                // logica de pintado de las estrellas
                // se hace diferente a lo anterior
                ForEach(1...5, id: \.self) { numero in
                    Image(
                        systemName: numero <= self.puntuacion
                            ? "star.fill" : "house.fill"
                    )
                    .foregroundStyle(
                        numero <= self.puntuacion
                            ? Color.yellow : Color.gray.opacity(0.5)
                    )
                    .font(.title)
                    
                    // MARK: animación de las estrellas ✨
                    // 📍 de esta forma reemplaza con Magia Oscura un icono por otro
                    .contentTransition(.symbolEffect(.replace))
                    
                    .onTapGesture {
                        puntuacion = numero
                    }
                }
            }
            .padding(10)

            VStack(alignment: .leading) {
                Text(descripcion)
            }

        }

    }
}

#Preview {

    @Previewable @State var destino = Destino(
        nombre: "New York",
        icono: "building.columns.fill",
        descripcion: "Destino de moda",
        color: .green,
        esFavorito: true,
        puntuacion: 3
    )

    VistaDetalleDestino(destino: $destino)
}
