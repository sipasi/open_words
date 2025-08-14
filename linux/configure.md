Configure Linux Version

You need libsecret-1-dev and libjsoncpp-dev on your machine to build the project, and libsecret-1-0 and libjsoncpp1 to run the application (add it as a dependency after packaging your app). If you using snapcraft to build the project use the following

 
```
parts:
  uet-lms:
    source: .
    plugin: flutter
    flutter-target: lib/main.dart
    build-packages:
      - libsecret-1-dev
      - libjsoncpp-dev
    stage-packages:
      - libsecret-1-0
      - libjsoncpp-dev
```
 
> https://pub.dev/packages/flutter_secure_storage#configure-linux-version