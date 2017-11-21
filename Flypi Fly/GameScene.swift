//
//  GameScene.swift
//  Flypi Fly
//
//  Created by Jose Pino on 19/9/17.
//  Copyright © 2017 Jose Pino. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var mosca = SKSpriteNode()
    var fondo = SKSpriteNode()
    var texturaMosca1 = SKTexture(imageNamed: "fly1.png")
    
    var tubo1 = SKSpriteNode()   // Para el tubo1 con la entrada por abajo
    var tubo2 = SKSpriteNode()   // Para el tubo2 con la entrada por arriba
    
    enum tipoNodo: UInt32 {      // Para las identificar y diferenciar los nodos/objetos. Tiene que ver con las colisiones
        case mosca = 1
        case tuboSuelo = 2    // Representa el suelo y los tubos. Ya que si choca con el suelo o tubo es lo mismo
        case espacioTubos = 4 // El espacio donde pasa la mosca entre los tubos
    }
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self  // Para las colisiones
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.agregarTubos), userInfo: nil, repeats: true)   // Timer para que aparezcan los tubos cada cierto timeInterval. El guión bajo tiene que ver con wildcard que también se usa por ejemplo en for _ in 1...3 {}
        
        
        agregarMosca()
        agregarFondo()
        agregarTubos()
        agregarSuelo()
        //agregarEspacios()  //Falta hacer la funcion, nos quedamos en la Clase 150
        
        
        
        
    }
    
    
    
    
    
    // Cuando el usuario pulsa la pantalla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        mosca.physicsBody!.isDynamic = true     // Cuando toca la pantalla el usuario se activa la "gravedad". O sea el cuerpo de la mosca tiene propiedas "fisicas"
        mosca.physicsBody!.velocity = (CGVector(dx: 0, dy: 0))
        mosca.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
        
    }

    
    
    func didBegin(_ contact: SKPhysicsContact) {        // Funcion que tiene que ver para distinguir los contactos (choques)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {

    }


    
    // Para el fondo
    func agregarFondo() {
        
        let texturaFondo = SKTexture(imageNamed: "fondo.png")
        
        // Acciones del fondo
        fondo = SKSpriteNode(texture: texturaFondo)
        fondo.size.height = self.frame.height
        self.addChild(fondo)
        fondo.zPosition = -1  // Para mandar al fondo, en el plano de abajo considerando XYZ
        
        
        // Para mover el fondo
        let movimientoFondo = SKAction.move(by: CGVector(dx: -texturaFondo.size().width, dy: 0), duration: 4)   //Le decimos que mueva el fondo en delta X
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx: texturaFondo.size().width, dy: 0), duration: 0)
        let movimientoInifinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo, movimientoFondoOrigen]))
        
        var i: CGFloat = 0
        
        while i < 2 {   // Para crear dos nodos de fondo
            fondo = SKSpriteNode(texture:texturaFondo)
            fondo.position = CGPoint(x: texturaFondo.size().width * i, y: self.frame.midY)
            fondo.size.height = self.frame.height
            fondo.zPosition = -1
            fondo.run(movimientoInifinitoFondo)
            self.addChild(fondo)
            i += 1
        }
    }
    
    
    
    
    // Para agregar los tubos
    func agregarTubos() {
        
        ///// Seccion 19 - Clase 140 Terminada /////
        
        let moverTubos = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width/80))
        
        let removerTubos = SKAction.removeFromParent()
        
        let moverRemoverTubos = SKAction.sequence([moverTubos, removerTubos])    // Secuencia de acciones que mueve los tubos y luego remueve
        
        
        let gapDificultad = mosca.size.height * 3 // Para la separación de los tubos
        
        let cantidadMovimientoAleatorio = CGFloat(arc4random() % UInt32(self.frame.height/2))
        let compensacionTubos = cantidadMovimientoAleatorio - self.frame.height/4
        
        let texturaTubo1 = SKTexture(imageNamed: "Tubo1")
        tubo1 = SKSpriteNode(texture: texturaTubo1)
        tubo1.position = CGPoint(x:self.frame.midX + self.frame.width, y:self.frame.midY + texturaTubo1.size().height/2 + gapDificultad + compensacionTubos)
        tubo1.size.height = self.frame.height
        tubo1.zPosition = 0
        
        tubo1.physicsBody = SKPhysicsBody(rectangleOf: texturaTubo1.size())     // Para la fisica de las colisiones de los tubos
        tubo1.physicsBody!.isDynamic = false
        
        tubo1.run(moverRemoverTubos)
        self.addChild(tubo1)
        
        
        let texturaTubo2 = SKTexture(imageNamed: "Tubo2")
        tubo2 = SKSpriteNode(texture: texturaTubo2)
        tubo2.position = CGPoint(x:self.frame.midX + self.frame.width, y:self.frame.midY - texturaTubo2.size().height/2 - gapDificultad + compensacionTubos)
        tubo2.size.height = self.frame.height
        tubo2.zPosition = 0
        
        tubo2.physicsBody = SKPhysicsBody(rectangleOf: texturaTubo1.size())     // Para la fisica de las colisiones de los tubos
        tubo2.physicsBody!.isDynamic = false
        
        tubo2.run(moverRemoverTubos)
        self.addChild(tubo2)
    }
    
    
    
    
    
    
    
    
    // Para el suelo
    func agregarSuelo() {
        
        let suelo = SKNode()
        suelo.position = CGPoint(x:-self.frame.midX, y:-self.frame.height/2)
        suelo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:self.frame.width, height:1))
        suelo.physicsBody!.isDynamic = false
        self.addChild(suelo)
    }
    
    
    
    // Para la mosca
    func agregarMosca() {
        texturaMosca1 = SKTexture(imageNamed: "fly1.png")
        let texturaMosca2 = SKTexture(imageNamed: "fly2.png")
        let animacion = SKAction.animate(with:[texturaMosca1, texturaMosca2], timePerFrame: 0.08)
        let animacionInfinita = SKAction.repeatForever(animacion)
        
        mosca = SKSpriteNode(texture: texturaMosca1)
        mosca.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        mosca.physicsBody = SKPhysicsBody(circleOfRadius: texturaMosca1.size().height/2)  //Le agregamos un cuerpo fisico a la mosca redondo
        mosca.zPosition = 1
        
        mosca.physicsBody!.isDynamic = false            // Para que al comienzo del juego no se caiga la mosca. Para que no se active la fisica al momento cuando se abre la App
        
        mosca.run(animacionInfinita)
        
        self.addChild(mosca)
    }

    
    
    
    
    
    

}
