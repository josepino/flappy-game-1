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
    
    
    
    override func didMove(to view: SKView) {
        
        agregarFondo()
        agregarSuelo()
        agregarMosca()
        
        
        
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
        
        
        
        mosca.run(animacionInfinita)
        
        self.addChild(mosca)
    }









}
