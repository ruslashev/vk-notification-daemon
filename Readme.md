# vk-notification-daemon

This is a small app for Sailfish OS that provides user with updates for the social network [vk](http://vk.com).

## motivation & goals

Getting notifications with the official android application sucks, since they don't come at all. Or they do, but if you leave it open on the main screen, but even then all you'll get is a message in the notification drawer - no sounds, no flashing led, no vibration.

So far it isn't even a daemon yet, but atleast it notifies. Sometime later it will actually be a background process that will auto start on device power on.

## testing, developing & helping out

Contributions are welcome! Anything, be it bug report (see [issues page](https://github.com/ruslashev/vk-notification-daemon/issues)) or code commits.

This project uses [nemo-qml-plugin-notifications](https://github.com/nemomobile/nemo-qml-plugin-notifications), but it is already included in the repo, so there is no need to worry about git submodules and you can just `git clone` and compile.

