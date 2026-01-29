//
//  VistaPerfilUsuario.swift
//  Curso-ios-demoVIajes
//
//  Created by Equipo 9 on 29/1/26.
//

import SwiftUI

struct VistaPerfilUsuario: View {
    
    @Binding var nombreUsuario: String
    
    var body: some View {
        Text("nombreUsuario: \(nombreUsuario)")
        
        Form {
            Section("Datos personales") {
                Text("Edita tus nombre aquí")
                    .font(.caption)
                    .foregroundStyle(.gray)
                TextField("tu nombre:", text: $nombreUsuario)
                    .font(.headline)
                    .foregroundStyle(.green)
            }
            
            Section("Estadísticas") {
                Label("Viajando desde 2024", systemImage: "calendar")
                Label("Nivel: Explorador", systemImage: "medal.fill")
            }
        }
        .navigationTitle("Editar Perfil")
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
