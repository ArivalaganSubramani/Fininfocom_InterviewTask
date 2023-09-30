package com.example.flutter_task

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val bluetoothChannel = "arivalagan/bluetoothChannel"


    @RequiresApi(Build.VERSION_CODES.S)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, bluetoothChannel).setMethodCallHandler { call, result ->
            if (call.method == "checkBluetooth") {


                val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                if (bluetoothAdapter == null) {
                    result.error("BLUETOOTH_UNAVAILABLE", "Bluetooth is not available on this device", null)
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val bluetoothPermission = Manifest.permission.BLUETOOTH
                    val bluetoothConnectPermission = Manifest.permission.BLUETOOTH_CONNECT
                    val bluetoothAdminPermission = Manifest.permission.BLUETOOTH_ADMIN

                    val permissionsToRequest = mutableListOf<String>()


                    if (checkSelfPermission(bluetoothConnectPermission) != PackageManager.PERMISSION_GRANTED) {
                        Log.d("MyBluetoothPlugin", "Bluetooth admin permission adding");

                        permissionsToRequest.add(bluetoothConnectPermission)
                    }
                    if (checkSelfPermission(bluetoothPermission) != PackageManager.PERMISSION_GRANTED) {
                        Log.d("MyBluetoothPlugin", "Bluetooth admin permission adding");

                        permissionsToRequest.add(bluetoothPermission)
                    }
                    if (checkSelfPermission(bluetoothAdminPermission) != PackageManager.PERMISSION_GRANTED) {
                        Log.d("MyBluetoothPlugin", "Bluetooth admin permission adding");

                        permissionsToRequest.add(bluetoothAdminPermission)
                    }

                    if (permissionsToRequest.isNotEmpty()) {
                        Log.d("MyBluetoothPlugin", "Bluetooth permission not granted. Requesting permission...");
                        // Request the permissions
                        ActivityCompat.requestPermissions(this, permissionsToRequest.toTypedArray(), 1)
                    }else {
                        Log.d("MyBluetoothPlugin", "Bluetooth permission  granted. ");
//
                        if (!bluetoothAdapter.isEnabled) {
                            Log.d("MyBluetoothPlugin", "Enabling bluetooth");
//
                            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)

                            activity.startActivityForResult(enableBtIntent, 1)
                        } else {
                            result.success("Bluetooth is already enabled")
                        }
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }

}
