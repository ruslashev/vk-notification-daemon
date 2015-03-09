#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
	QGuiApplication *app = SailfishApp::application(argc, argv);
	QQuickView *view = SailfishApp::createView();

	// TokenManager token_manager;
	// view->rootContext()->setContextProperty("token_manager", &token_manager);
	view->setSource(
			SailfishApp::pathTo(
				QString("qml/vk-notification-daemon.qml")));
	view->show();

	int exit_status = app->exec();

	delete view;
	delete app;

	return exit_status;
}

