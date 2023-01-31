#ifndef APPUV_H
#define APPUV_H
#include <QObject>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QHttpPart>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonParseError>
#include <QTimer>
#include <QtDebug>


class AppUv: public QObject
{
    Q_OBJECT
public:
    explicit AppUv(QObject *parent = nullptr);
private:
    QNetworkAccessManager *manager;
    QNetworkRequest request;
    QString answer;
    uint32_t datacount=10;
    uint32_t channel=0;
    QVector<QVector<double>> numdata;
private slots:
    void managerFinished(QNetworkReply *reply);
    void onRequest();
public slots:
    uint32_t getChannel();
signals:
    void newData(QVector<QVector<double>>);
};

#endif // APPUV_H

