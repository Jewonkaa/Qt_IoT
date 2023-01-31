import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtCharts 2.15
import QtQuick.Layouts 1.3





ApplicationWindow {
    Material.theme: Material.Dark
    Material.accent: Material.Orange
    width: 900
    height: 700
    visible: true
    //title: qsTr("IoT ")

   header: TabBar {
        id: bar
        width: parent.width

        TabButton {
            text: qsTr("Air Parameters")


        }
        TabButton {
            text: qsTr("Light Spectrum")
        }
        TabButton {
            text: qsTr("Ari Quality")

        }
        TabButton {
            text: qsTr("Add new sensor")
        }

    }


    StackLayout {
        anchors.fill: parent
        currentIndex: bar.currentIndex


        Item {
            id: homeTab

//                Text {
//                id: textInfo

//        //        color: "#ffffff"
//        //        text: qsTr("")
//        //        font.pixelSize: 15
//                }

                Frame{
                    id: frameGauge
                  height: width/3.5
                    anchors.top: bar.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10



                    Gauge {
                        id: gaugePressure
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: -0.3*parent.width
                        size: 0.8*parent.height
                        colorCircle: "#00C0ff"
                        colorBackground: "#202020"
                        lineWidth: 0.1*width
                        showGlow: true
                        quantity: "Pressure"
                        unit: "hPa"
                        from:800
                        to:1200
                        value: from
                    }
                    Gauge {
                        id: gaugeTemperature
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: 0
                        size: parent.height
                        colorCircle: "#ff8000"
                        colorBackground: "#202020"
                        lineWidth: 0.1*width
                        showGlow: true
                        quantity: "Temperature"
                        unit: "\xB0C"
                        from:0
                        to:85
                        value: from
                    }
                    Gauge {
                        id: gaugeHumidity
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: 0.3*parent.width
                        size: 0.8*parent.height
                        colorCircle: "#00ffc0"
                        colorBackground: "#202020"
                        lineWidth: 0.1*width
                        showBackground: true
                        showGlow: true
                        quantity: "Humidity"
                        unit: "%"
                        from:10
                        to:100
                        value: from
                    }



                }

                ChartView {
                    id: line
                    anchors.top: frameGauge.bottom
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.bottom: parent.bottom
                    theme: ChartView.ChartThemeDark
                    ValuesAxis {
                        id: axisX
                        min: 1
                        max: 10
                        tickCount: max
                    }
                    ValuesAxis {
                        id: axisY
                        min: 0
                        max: 120
                        tickCount: 7
                    }
                    LineSeries {
                        id: series1
                        name: "Pressure x10 [hPa]"
                        axisX: axisX
                        axisY: axisY
                        color: "#00C0ff"
                    }
                    LineSeries {
                        id: series2
                        name: "Temperature [\xB0C]"
                        axisX: axisX
                        axisY: axisY
                        color: "#ff8000"
                    }
                    LineSeries {
                        id: series3
                        name: "Humidity [%]"
                        axisX: axisX
                        axisY: axisY
                        color: "#00ffc0"
                    }
                }

                Connections {
                    target: appcore
                    function onNewData(v) {
                        var channel = appcore.getChannel()
                        console.log("dupa11")
                        console.log(channel)
                        //console.log(v, v.length)
                        if (v.length > 0) {
                            axisX.max = v.length
                            axisX. tickCount = axisX.max
                //            textInfo.text = "Channel ID: "+channel
                            gaugeTemperature.value = v[v.length-1][0]
                            gaugePressure.value = v[v.length-1][1]
                            gaugeHumidity.value = v[v.length-1][2]

                            series1.clear();
                            series2.clear();
                            series3.clear();
                            for (var i = 0; i < v.length; i++) {
                                series2.append(v.length-i, v[i][0])
                                series1.append(v.length-i, v[i][1]/10)
                                series3.append(v.length-i, v[i][2])
                            }
                        }
                    }
                }
        } // end of first sensor


        Item {
            id: discoverTab

            Text {
            id: textInfoo
            anchors.centerIn: parent
    //        color: "#ffffff"
    //        text: qsTr("")
    //        font.pixelSize: 15
            }
            ChartView {
                title: "Numerical Data for Dummies"
                anchors.fill: parent
                legend.visible: false
                antialiasing: true
                ValuesAxis {
                    id: axisXx
                    min: 1
                    max: 150
//                    tickCount: max
                }
                ValuesAxis {
                    id: axisYy
                    min: 100
                    max: 1500
//                    tickCount: 7
                }
                LineSeries {
                    id: seriesA

                    axisX: axisXx
                    axisY: axisYy
                    color: "#00C0ff"
                }
                LineSeries {
                    id: seriesB

                    axisX: axisXx
                    axisY: axisYy
                    color: "#ff8000"
                }




            }
            Connections  {

                target: appuv
                function onNewData(v) {
                    var   channel = appuv.getChannel()
                     console.log("dupa22")
                    console.log(channel)
                    //console.log(v, v.length)
                    if (v.length > 0) {
                        axisXx.max = v.length
                        axisXx. tickCount = axisXx.max
            //            textInfo.text = "Channel ID: "+channel


                        seriesA.clear();
                        seriesB.clear();

                        for (var i = 0; i < v.length; i++) {
                            seriesB.append(v.length-i, v[i][0])
                            seriesA.append(v.length-i, v[i][1])

                        }
                    }
                }
            }



        }// end of secend

        }

 }






