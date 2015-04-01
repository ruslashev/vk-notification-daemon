_SRC = $$PWD/nemo-qml-plugin-notifications/src

system(cd $$_SRC && \
       qdbusxml2cpp org.freedesktop.Notifications.xml \
           -p notificationmanagerproxy \
           -c NotificationManagerProxy \
           -i notification.h)

HEADERS += \
        $$_SRC/notification.h \
        $$_SRC/notificationmanagerproxy.h

SOURCES += \
        $$_SRC/notification.cpp \
        $$_SRC/notificationmanagerproxy.cpp

INCLUDEPATH += $$_SRC

