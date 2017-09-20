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
    
    
    override func didMove(to view: SKView) {
        
        let texturaMosca1 = SKTexture(imageNamed: "fly1.png")
        let texturaMosca2 = SKTexture(imageNamed: "fly2.png")
        
        let animacion = SKAction.animate(with:[texturaMosca1, texturaMosca2], timePerFrame: 0.08)
        
        let animacionInfinita = SKAction.repeatForever(animacion)
        
        
        mosca = SKSpriteNode(texture: texturaMosca1)
        
        mosca.position = CGPoint(x:0.0, y:0.0)
        
        mosca.run(animacionInfinita)
        
        self.addChild(mosca)
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }

    
    override func update(_ currentTime: TimeInterval) {

    }
}
