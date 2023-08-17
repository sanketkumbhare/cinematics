# Flutter Module Integration Steps in Android

1. Adding Flutter AAR module to project with Build Configuration File : Groovy DSL
2. Adding Flutter AAR module to project with Build Configuration File : Kotlin DSL

Note:  maven repo added to the settings.gradle for flutter is unsupported under dependencyResolutionManagement,
       Delete dependencyResolutionManagement block and add any extra repo to the project level build.gradle file.



## Groovy DSL
All the old projects mostly use Groovy DSL

a. Add the following code to app level build.gradle
```groovy
repositories {
  // Add these two maven entries.
  String storageUrl = System.env.FLUTTER_STORAGE_BASE_URL ?: "https://storage.googleapis.com"
  maven {
    url '../lib/project_name/build/host/outputs/repo'
  }
  maven {
    url "$storageUrl/download.flutter.io"
  }
}

dependencies {
  // Add these three entries.
  debugImplementation 'com.example.flutter_module:flutter_debug:1.0'
  profileImplementation 'com.example.flutter_module:flutter_profile:1.0'
  releaseImplementation 'com.example.flutter_module:flutter_release:1.0'
}
```

b. Add the code in project level build.gradle
```groovy
buildscript {
    repositories {
        google()
        mavenCentral()
        String storageUrl = System.env.FLUTTER_STORAGE_BASE_URL ?: "https://storage.googleapis.com"
        maven {
            url '../lib/project_name/build/host/outputs/repo'
        }
        maven {
            url "$storageUrl/download.flutter.io"
       }
    }
}
```

## Kotlin DSL
All the new Android projects mostly use Kotlin DSL

a. Add the following code to app level build.gradle
```kotlin
repositories{
    val storageUrl = System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"
    repositories {
        google()
        mavenCentral()
        maven {
            setUrl("../lib/project_name/build/host/outputs/repo")
        }
        maven {
            setUrl("$storageUrl/download.flutter.io")
        }
    }
}

dependencies {
  debugImplementation ("com.mobisoft.home_derma:flutter_debug:1.0")
  profileImplementation ("com.mobisoft.home_derma:flutter_profile:1.0")
  releaseImplementation ("com.mobisoft.home_derma:flutter_release:1.0")
}

```

b.Add the following code to project level build.gradle
```kotlin

buildscript {
    val storageUrl = System.getenv("FLUTTER_STORAGE_BASE_URL") ?: "https://storage.googleapis.com"
    repositories {
        google()
        mavenCentral()
        maven {
            setUrl("../lib/project_name/build/host/outputs/repo")
        }
        maven {
            setUrl("$storageUrl/download.flutter.io")
        }
    }
}

```

### Flutter file directory for AAR

* Flutter module will get recognised only if it has proper directory 
* example:  file_name/build/host/outputs/repo/com/mobisoft/flutter_module/
```tree
build/host/outputs/repo
└── com
    └── example
        └── flutter_module
            ├── flutter_release
            │   ├── 1.0
            │   │   ├── flutter_release-1.0.aar
            │   │   ├── flutter_release-1.0.aar.md5
            │   │   ├── flutter_release-1.0.aar.sha1
            │   │   ├── flutter_release-1.0.pom
            │   │   ├── flutter_release-1.0.pom.md5
            │   │   └── flutter_release-1.0.pom.sha1
            │   ├── maven-metadata.xml
            │   ├── maven-metadata.xml.md5
            │   └── maven-metadata.xml.sha1
            ├── flutter_profile
            │   ├── ...
            └── flutter_debug
                └── ...
```

## Create lib directory 
* Create lib directory in host project
* Copy paste the AAR module inside the lib directory

## Create Application to use Flutter Engine

* Once application file created extend it with app's Application

* open Manifest.xml and add android:name under the <application> tag

* Add the Following code in application file

```application
class MyApplication:Application() {
    lateinit var flutterEngine: FlutterEngine

    companion object{
        const val FLUTTER_ENGINE_NAME = "flutter_engine_name"
    }

    override fun onCreate() {
        super.onCreate()

        flutterEngine = FlutterEngine(this)


        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_NAME,flutterEngine)
    }
}
```

### Changes to Manifest File 

* Add Activity tag for flutter
```
  <activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```
#### Changes in activity file

* Create any button and add update its clickListener
* Add the following code to clickListener and invoke FlutterActivity
```
startActivity(
                FlutterActivity.withCachedEngine(MyApplication.FLUTTER_ENGINE_NAME).build(context)
            )
```
