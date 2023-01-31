#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "appcore.h"
#include "appuv.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    AppCore appcore;
    AppUv appuv;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("appcore", &appcore);
    engine.rootContext()->setContextProperty("appuv", &appuv);
    const QUrl url(u"qrc:/Praca_inz/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
