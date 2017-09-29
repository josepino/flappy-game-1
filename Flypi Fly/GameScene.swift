//
//  GameScene.swift
//  Flypi Fly
//
//  Created by Jose Pino on 19/9/17.
//  Copyright © 2017 Jose Pino. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mosca = SKSpriteNode()
    var fondo = SKSpriteNode()
    var texturaMosca1 = SKTexture(imageNamed: "fly1.png")
    
    var tubo1 = SKSpriteNode()   // Para el tubo1 con la entrada por abajo
    var tubo2 = SKSpriteNode()   // Para el tubo2 con la entrada por arriba
    
    
    override func didMove(to view: SKView) {
        
        
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.agregarTubos), userInfo: nil, repeats: true)   // Timer para que aparezcan los tubos cada cierto timeInterval. El guión bajo tiene que ver con wildcard que también se usa por ejemplo en for _ in 1...3 {}
        
        
        agregarMosca()
        agregarFondo()
        agregarTubos()
        agregarSuelo()
        
        
        
        
    }
    
    
    
    
    
    // Cuando el usuario pulsa la pantalla
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mosca.physicsBody = SKPhysicsBody(circleOfRadius: texturaMosca1.size().height/2)  //Le agregamos un cuerpo fisico a la mosca redondo
        mosca.physicsBody!.isDynamic = true
        mosca.physicsBody!.velocity = (CGVector(dx: 0, dy: 0))
        mosca.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
        
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
        
        let gapDificultad = mosca.size.height * 3 // Para la separación de los tubos
        
        let cantidadMovimientoAleatorio = CGFloat(arc4random() % UInt32(self.frame.height/2))
        let compensacionTubos = cantidadMovimientoAleatorio - self.frame.height/4
        
        let texturaTubo1 = SKTexture(imageNamed: "Tubo1")
        tubo1 = SKSpriteNode(texture: texturaTubo1)
        tubo1.position = CGPoint(x:self.frame.midX + self.frame.width, y:self.frame.midY + texturaTubo1.size().height/2 + gapDificultad + compensacionTubos)
        tubo1.size.height = self.frame.height
        tubo1.zPosition = 0
        
        tubo1.run(moverTubos)
        self.addChild(tubo1)
        
        
        let texturaTubo2 = SKTexture(imageNamed: "Tubo2")
        tubo2 = SKSpriteNode(texture: texturaTubo2)
        tubo2.position = CGPoint(x:self.frame.midX + self.frame.width, y:self.frame.midY - texturaTubo2.size().height/2 - gapDificultad + compensacionTubos)
        tubo2.size.height = self.frame.height
        tubo2.zPosition = 0
        
        tubo2.run(moverTubos)
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
        mosca.zPosition = 1
        
        mosca.run(animacionInfinita)
        
        self.addChild(mosca)
    }









}
