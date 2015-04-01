#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <notification.h>
#include <QtQml>

int main(int argc, char *argv[])
{
	QGuiApplication *app = SailfishApp::application(argc, argv);
	QQuickView *view = SailfishApp::createView();

	qmlRegisterType<Notification>("harbour.vknotificationdaemon.notifications",
			1, 0, "Notification");

	view->setSource(SailfishApp::pathTo(
				QString("qml/vk-notification-daemon.qml")));
	view->show();

	int exit_status = app->exec();

	delete view;
	delete app;

	return exit_status;
}

