//
//  Destino.swift
//  Curso-ios-demoVIajes
//
//  Created by Equipo 9 on 29/1/26.
//

import SwiftUI

struct Destino: Identifiable, Hashable {
    let id = UUID()
    let nombre: String
    let icono: String
    var descripcion: String
    let color: Color
    var esFavorito: Bool = false
    var puntuacion: Int = 0
}
