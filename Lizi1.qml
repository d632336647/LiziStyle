import QtQuick 2.0
import QtQuick.Particles 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
Rectangle{
    anchors.centerIn: parent
    id:root
    width: 300
    height: 300
    color: "#1f1f1f"
    ParticleSystem{
        id:particles
    }
    TextField{
        text: "dsada"
        placeholderText: "input..."
        focus: true
        style:TextFieldStyle{
           textColor: Qt.rgba(0,0,0,0.87)
           background: Rectangle{
           radius: 4
           color: "#f2f2f2"
           implicitWidth: 100
           implicitHeight: 24
           }
        }
    }
    Rectangle{
        id:move
        width: 100
        height: 100
        color: "#00000000"
        PathAnimation {
            id:pathA
            target:move                     //运动的对象
            duration: 6000                  //运动过程中运动的时间
            orientationEntryDuration:100    //运动过程中进入的时间
            orientationExitDuration:100     //运动过程中退出的时间
//            easing.type:Easing.InOutCubic   //速度曲线
            loops:Animation.Infinite
              path: Path {
                  startX: -100
                  startY:-400
//                  PathCurve { x: 500; y: 500}

                  PathArc{                  //路径规划-圆
                    x:101                   //结束点的相对位置
                    y:401
                    useLargeArc: true       //大弧路径
                    radiusX: 50            //半径
                    radiusY:50
                    direction: PathArc.Counterclockwise
                  }
              }
          }
        MouseArea{
        anchors.fill:parent
        id:modese
        onClicked: pathA.start()
        }
    }
    Emitter{
        anchors.fill: move
        id:emitter
        anchors.centerIn: parent
        width: 1
        height: 1
        system: particles
        emitRate: 100       //发射量
        lifeSpan: 10000
        lifeSpanVariation: 500
        size: 16
        endSize: 32
        //速度
        velocity: AngleDirection {
            angle: 0            //角度
//            angleVariation: 360
            magnitude: 200      //速度
//            magnitudeVariation: 10
        }
//        //速度
//        velocity: PointDirection  {
//            x:100
//            y:10
//            xVariation: 0
//            yVariation: 0
//        }
//        //加速度
//        acceleration: AngleDirection{
//            angle: 180
//            angleVariation: 360
//            magnitude: 50
//            magnitudeVariation: 5
//        }
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            border.color: "green"
            border.width: 1
            opacity: 0.8
        }
    }
    //影响器 吸引到 pointX pointY
    Attractor {
            anchors.left: parent.right
            width: 300; height: 300
            system: particles
            pointX: 300
            pointY: 300
            strength: 1.0
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: att
                    text: qsTr("吸引")
                    color: "red"
                }
            }
        }
    //影响器 改变轨迹
    Wander {
        anchors.left: parent.right
        anchors.top: parent.bottom
        width: 300; height: 300
            system: particles
            affectedParameter: Wander.Position  //需要改变的属性
            pace: 200                           //属性指定每秒该属性变化的最大值
            xVariance: 240
            yVariance: 240
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: wan
                    text: qsTr("改变轨迹")
                    color: "red"
                }
            }
        }
    //影响器 减速
    Friction {
        anchors.top: parent.bottom
        width: 300; height: 300
            system: particles
            factor : 0.8
            threshold: 5
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: fri
                    text: qsTr("减速")
                    color: "red"
                }
            }
        }
    //影响器 给一个加速度
    Gravity {
        anchors.right: parent.left
        width: 300; height: 300
            system: particles
            magnitude: 50
            angle: 90
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: gra
                    text: qsTr("加速度")
                    color: "red"
                }
            }
        }
    //影响器 随机力
    Turbulence {
        anchors.bottom: parent.top
        width: 300; height: 300
            system: particles
            strength: 200
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: tur
                    text: qsTr("随机力")
                    color: "red"
                }
            }
        }
    //影响器 生命
    Age {
        anchors.bottom: parent.top
        anchors.right: parent.left
        width: 300; height: 300
            system: particles
            advancePosition: false  //如果为true 会使粒子的状态（位置大小 等） 瞬变到 1000所应该在的状态
            lifeLeft: 1000
            once: true
            Rectangle {
                anchors.fill: parent
                color: 'transparent'
                border.color: 'green'
                border.width: 2
                opacity: 0.8
                Text {
                    id: age
                    text: qsTr("生命")
                    color: "red"
                }
            }
        }

//    ItemParticle{
//        system: particles
//        delegate: Rectangle{
//            width: 10
//            height: 10
//            color: "yellow"
//            radius:10
//            transform: Rotation {origin.x: 0; origin.y: 0
//                axis{x: 1; y: 1; z: 1}
//                angle: 0
//            }
//            Image {
//                id: ima
//                source: "qrc:/image/灰-刻轮.png"
//                anchors.fill: parent
//            }
//        }
//    }
    ImageParticle{
        system: particles
        source:"qrc:/image/xx.png"
//        transform: Rotation {origin.x: 0; origin.y: 0
//            axis{x: 0; y: 1; z: 0}
//            angle: 89
//        }
        color: '#FFD700'
        colorVariation: 0.6
        rotation: 15                    //角度
        rotationVariation: 5            //角度误差
        rotationVelocity: 45            //旋转速度
        rotationVelocityVariation: 15   //旋转速度误差

        entryEffect: ImageParticle.Scale
    }
}
