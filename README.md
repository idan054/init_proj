# init_messaging - com.biton.messaging

My Flutter init project

## To start use (Setup)

### ReName app Name & package:
##### 1) flutter pub global activate rename
##### 2) flutter pub global run rename --appname "Your App Name"
##### 3) flutter pub global run rename --bundleId com.biton.messaging // (CTRL + R needed for AndroidManifest.xml)
##### 3.1) Make sure bundleId & App name with (CTRL + R)
##### 4) Replace the icon on - assets/messages_icon.png
##### 5) flutter pub pub run flutter_launcher_icons:main

export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home" (Run this before if needed)
./gradlew signingReport of Debug.jks:
SHA1:   D0:87:F0:61:6F:B1:13:9B:C1:9E:DC:18:F5:49:F3:DD:3A:1C:1E:B1
SHA256: 5B:67:14:C9:6E:A5:59:C4:00:22:77:46:49:ED:E3:45:B3:B1:21:38:9F:D1:1E:CC:FB:8E:33:4D:46:70:F0:DD
