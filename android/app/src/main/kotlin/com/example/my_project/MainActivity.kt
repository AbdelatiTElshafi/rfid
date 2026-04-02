package com.example.my_project

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.concurrent.thread

class MainActivity : FlutterActivity() {
    private val CHANNEL = "rfid_channel"
    private val PERMISSION_REQUEST_CODE = 1001

    private lateinit var rfidHandler: RFIDHandler
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        rfidHandler = RFIDHandler(this)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "connectRFID" -> {
                    if (!hasBluetoothPermissions()) {
                        requestBluetoothPermissions()
                        result.success(false)
                        return@setMethodCallHandler
                    }

                    thread {
                        val success = rfidHandler.connectReader { tagId ->
                            runOnUiThread {
                                methodChannel.invokeMethod("onTagRead", tagId)
                            }
                        }

                        runOnUiThread {
                            result.success(success)
                        }
                    }
                }

                "startScan" -> {
                    val success = rfidHandler.startInventory()
                    result.success(success)
                }

                "stopScan" -> {
                    val success = rfidHandler.stopInventory()
                    result.success(success)
                }

                "disableRFID" -> {
                    val success = rfidHandler.disableReader()
                    result.success(success)
                }

                "disconnectRFID" -> {
                    val success = rfidHandler.disconnectReader()
                    result.success(success)
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun hasBluetoothPermissions(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.BLUETOOTH_CONNECT
            ) == PackageManager.PERMISSION_GRANTED &&
                    ContextCompat.checkSelfPermission(
                        this,
                        Manifest.permission.BLUETOOTH_SCAN
                    ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    private fun requestBluetoothPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(
                    Manifest.permission.BLUETOOTH_CONNECT,
                    Manifest.permission.BLUETOOTH_SCAN
                ),
                PERMISSION_REQUEST_CODE
            )
        }
    }
}