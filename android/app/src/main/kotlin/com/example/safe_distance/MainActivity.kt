package com.example.safe_distance

import android.content.Context
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.safe_distance/sensors"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSensors") {
                val packageManager: PackageManager = applicationContext.packageManager
                val sensors = packageManager.getSystemAvailableFeatures()
                    .filter { it.name != null }
                    .map { it.name }
                result.success(sensors)
            } else {
                result.notImplemented()
            }
        }
    }
}

