import QtQuick 2.0
import QtQuick.Particles 2.0
Rectangle{
    id:root
    width: 400
    height: 900
    color: "#1f1f1f"
//    property bool tracer: false
    ParticleSystem{
        id:particleSystem
    }
    ImageParticle{
    id:smokePainter
    system: particleSystem
    source: "qrc:/image/xx.png"
    groups: ['smoke']
    alpha: 0.3
    entryEffect:  ImageParticle.None
    }
    ImageParticle{
    id:rocketPainter
    system: particleSystem
    source: "qrc:/image/rocket.png"
    groups: ['rocket']
    }
    Emitter{
        id:rocketEmitter
        anchors.bottom: parent.bottom
        width: parent.width
        height: 40
        system: particleSystem
        group:"rocket"
        emitRate: 2
        maximumEmitted: 4
        lifeSpan: 4800
        lifeSpanVariation: 400
        size: 32
        velocity: AngleDirection{
            angle: 270
            magnitude: 250
            magnitudeVariation: 50
        }
        acceleration: AngleDirection{
            angle: 90
            magnitude: 50
        }
//        Tracer{
//            color:"red"
//            visible:root.tracer
//        }
    }
    TrailEmitter{
        id:smokeEmitter
        system:particleSystem
        emitHeight: 1
        emitWidth: 4
        group: 'smoke'
        follow: 'rocket'
        emitRatePerParticle: 96
        velocity: AngleDirection{
            angle: 90
            magnitude: 100
            magnitudeVariation: 10
        }
        lifeSpan: 200
        size: 16
        sizeVariation: 4
        endSize: 0
    }

    Friction{
        groups: ['rocket']
        anchors.top: parent.top
        width: parent.width
        height: 80
        system: particleSystem
        threshold: 5
        factor:0.9
    }
    Turbulence{
        groups: ['rocket']
        anchors.bottom: parent.bottom
        width: parent.width
        height: 900
        system: particleSystem
        strength: 50
    }

    ImageParticle{
        id:sparklePainter
        system: particleSystem
        groups: ['sparkle']
        color: "red"
        colorVariation: 0.6
        source: "qrc:/image/xx.png"
        width: 20
        height: 100
        alpha: 0.3
        opacity: 0.2
    }
    GroupGoal{
        id:rocketChanger
        anchors.top: parent.top
        width: parent.width
        height: 600
        system: particleSystem
        groups: ['rocket']
        goalState: 'explosion'
        jump: true
    }

    ParticleGroup{
        name:"explosion"
        system: particleSystem

    TrailEmitter{
        id:explosionEmitter
        anchors.fill: parent
        group: 'sparkle'
        follow: 'rocket'
        lifeSpan: 250
        emitRatePerParticle: 200
        size: 25

        velocity: AngleDirection{
            angle: -90
            angleVariation: 180
            magnitude: 300
        }
    }
    TrailEmitter{
        id:explosion2Emitter
        anchors.fill: parent
        group:'sparkle'
        follow: 'rocket'
        lifeSpan: 250
        emitRatePerParticle: 100
        size: 25
        velocity: AngleDirection{
            angle: 90
            angleVariation: 180
            magnitude: 300
        }
    }
    Age{
        advancePosition:false
        lifeLeft:1000
        system: particleSystem
//        anchors.fill: rocketChanger
        width: root.width
        height: root.height
        once: true
    }
    Turbulence{
        groups: ['sparkle']
        width: root.width
        height: root.height
        system: particleSystem
        strength: 500
    }

}








}
