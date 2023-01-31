#include "appcore.h"

AppCore::AppCore(QObject *parent)
    : QObject{parent}
{
    channel = {1674986};
//    channelLight = {1674983};
//    channelCo = {1945638};
    manager = new QNetworkAccessManager();
    connect(manager, &QNetworkAccessManager::finished, this, &AppCore::managerFinished);
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &AppCore::onRequest);
    timer->start(5000); //5 sec
    onRequest();
}
void AppCore::managerFinished(QNetworkReply *reply)
{
    if (reply->error()) {
        qDebug() << reply->errorString();
        return;
    }
    answer = reply->readAll();
    qDebug() << answer;
    QJsonDocument doc = QJsonDocument::fromJson(answer.toUtf8());
    if (doc.isArray()) {
    } else if (doc.isObject()) {
        QJsonObject obj = doc.object();
        QJsonObject::iterator it;
        for(it=obj.begin();it!=obj.end();it++) {
            if(it.value().isObject()) {
            }else if(it.value().isArray()) {
                QJsonArray jArray = it.value().toArray();
                QVector<double> temp(3);
                numdata.resize(0);
                foreach (const QJsonValue & v, jArray) {
                    temp[0]=v.toObject().value("field1").toString().toDouble();
                    temp[1]=v.toObject().value("field2").toString().toDouble();
                    temp[2]=v.toObject().value("field3").toString().toDouble();

                    numdata.append(temp);
                }
            } else {
                if (it.value().isString()) {
                }
                if (it.value().isDouble()) {
                }
            }
        }
    }
    emit newData(numdata);
}
void AppCore::onRequest()
{
    qDebug()<<"Receive";
    QString requeststring="https://api.thingspeak.com/channels/"+QString("%1").arg(channel)+"/feeds.json?results="+QString("%1").arg(datacount);
            request.setUrl(QUrl(requeststring));
    manager->get(request);

}
uint32_t AppCore::getChannel()//uint8_t channel)
{
    return channel;


//    switch(channel)
//    {
//    case 1:
//    return channelParameter;
//        break;
//    case 2:
//    return channelLight;
//        break;
//    case 3:
//    return channelCo;
//        break;
//    default:
//        break;
//    }

}
