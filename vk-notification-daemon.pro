# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = vk-notification-daemon

CONFIG += sailfishapp

QT += dbus

include(src/notifications.pri)

SOURCES += src/vk-notification-daemon.cpp

OTHER_FILES += qml/vk-notification-daemon.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/vk-notification-daemon.changes.in \
    rpm/vk-notification-daemon.spec \
    rpm/vk-notification-daemon.yaml \
    translations/*.ts \
    vk-notification-daemon.desktop

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/vk-notification-daemon-de.ts

