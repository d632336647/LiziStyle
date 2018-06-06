import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0

Window {
    visible: true
    width: 900
    height: 900
    title: qsTr("Hello World")
    color: "#1f1f1f"

    Item{
        anchors.fill: parent


        Rectangle{
            anchors.fill: parent
            color:"#1f1f1f"
                  ProgressBar {
                      width: 300
                      property var value1: value
                      id:prog
                      value: 0.5
                      style:ProgressBarStyle{
                        progress: Rectangle{
                            id:inprogress
                            color: "#208020"
                            radius: 8
                            clip: true
                            LinearGradient{
                                width: parent.width
                                height: parent.height
                                start: Qt.point(0,0)
                                end: Qt.point(parent.width,0)
                                source:inprogress
                                gradient: Gradient{
                                    GradientStop{position: 0.0;color: "#70b01e"}
                                    GradientStop{position: 1.0;color: "#dff89b"}
                                }
                            }
                            ParticleSystem{
                                id:particles
                            }
                            ImageParticle{
                                system: particles
                                source:"qrc:/image/xx.png"
//                                color: 'red'
                                colorVariation: 0.1
                                rotationVariation: 5            //角度误差
                                rotationVelocityVariation: 15   //旋转速度误差
                                //entryEffect: ImageParticle.Scale
                            }
                            ItemParticle{

                            }
                            Emitter{
                                id:emitter
                                anchors.right: inprogress.right
                                anchors.rightMargin: 2
                                anchors.verticalCenter: inprogress.verticalCenter
                                width: 1
                                height: 10
                                system: particles
                                emitRate: 10       //发射量
                                maximumEmitted:60
                                lifeSpan: 2000
                                lifeSpanVariation: 10
                                size: 5
                                endSize: 1
                                //速度
                                velocity: AngleDirection {
                                    angle: 180            //角度
                                    //angleVariation: 360
                                    magnitude: 20      //速度
                                    //magnitudeVariation: 10
                                }
                            }
                        }

                      }

                      NumberAnimation {
                              id:valueChange
                              target: prog
                              to:prog.value1
                              property: "value"
                              duration: 300
                              easing.type: Easing.Linear
                          }
                  }
            MouseArea{
            anchors.fill: parent
            onClicked: {
                prog.value1 +=0.1
                if(prog.value1 > 1)
                {
                    prog.value1 =0
                }
                valueChange.start()
            }
            }
        }
    }
}
