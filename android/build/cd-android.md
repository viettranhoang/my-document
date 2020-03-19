# CD Android

1. Tạo Service account, get .p12 hoặc JSON key file theo tutorial [này](https://guides.codepath.com/android/automating-publishing-to-the-play-store). Thêm file đó vào `/app` và add vô build.gradle:
```
android { ... }

play {
    serviceAccountCredentials = file("your-key.json")
}
```

2. Thêm dependence lib vô build.gradle (app) - replace `apply plugin: 'com.android.application'` by below code:
```
plugins {
    id 'com.android.application'
    id 'com.github.triplet.play' version '2.7.2'
}
```

3. Thêm 1 vài config về bản build vô trong build.gradle (app)
```
android { ... }

play {
track = 'internal' //'alpha','beta' or 'production'

}
```

4. Thêm release note:

Tạo file `src/main/play/release-notes/en-US/default.txt` chứa release note. 

Nếu là bản beta và tiếng việt thì sẽ là: `src/main/play/release-notes/vi/beta.txt`


4. Publish App Bundle
```
./gradlew publishBundle
```

Publish APK:
```
./gradlew publishApk
```

> Source: [1](https://github.com/Triple-T/gradle-play-publisher)