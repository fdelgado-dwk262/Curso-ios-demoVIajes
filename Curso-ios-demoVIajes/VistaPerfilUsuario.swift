//
//  VistaPerfilUsuario.swift
//  Curso-ios-demoVIajes
//
//  Created by Equipo 9 on 29/1/26.
//

import SwiftUI

struct VistaPerfilUsuario: View {
    
    @Binding var nombreUsuario: String
    
    // solucion para identificar si el dispositivo esta en
    // landscape o portrait
    // usaremos una variable interna que tenemos de "definir"
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    
    var body: some View {
//        Text("nombreUsuario: \(nombreUsuario)")
        
        Form {
            Section("Datos personales") {
                Text("Edita tus nombre aquí")
                    .font(.caption)
                    .foregroundStyle(.gray)
                TextField("Escribre tu nombre", text: $nombreUsuario)
                    .font(.headline)
                    .foregroundStyle(.green)
            }
            
            Section("Estadísticas") {
                Label("Viajando desde 2024", systemImage: "calendar")
                Label("Nivel: Explorador", systemImage: "medal.fill")
            }
        }
        .navigationTitle("Editar Perfil")
        // deshabilitar el scroll para que no se mueva la pantalla
        // pero nos puede dar mas problemas en modo horizontal
        //.scrollDisabled(true)
        
        // para ello se soluciona de la siguiente forma no existe un método.
        // hay que hacer una ÑAPIOS ( ñaoa ios )
        // lógica
        // si el alto es "Regular" ( vertical en Iphone) -> secroll desactivado
        // y si es "Compact" (horizontal en Iphone ) -> scroll activado
        .scrollDisabled(verticalSizeClass == .regular ? true : false)
        
    }
}

#Preview {
    // dos formas de implementar el parametro
    
    // A iniciañlizando la variable
    // VistaPerfilUsuario(nombreUsuario: .constant("NombreDemo")
    
    // B necesitamos una variable de estado
    // ( uso habitual y para que el canvas sea interactivo con variables de estado )
    @Previewable @State var nombreUsuario: String = "Previewable Demo"
    VistaPerfilUsuario(nombreUsuario: $nombreUsuario)
}
