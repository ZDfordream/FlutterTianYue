package com.zhudong.tianyue;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.util.Log;

import com.amap.api.maps2d.MapView;

import java.util.concurrent.TimeUnit;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.Observable;
import io.reactivex.disposables.Disposable;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/battery";
    public static final String STREAM = "com.yourcompany.eventchannelsample/stream";
    private MapView mapView;
    private Disposable timerSubscription;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        mapView = new MapView(MainActivity.this);
        mapView.onCreate(savedInstanceState);
        ViewRegistrant.registerWith(this, mapView);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("getBatteryLevel")) {
                        int batteryLevel = MainActivity.this.getBatteryLevel();

                        if (batteryLevel != -1) {
                            result.success(batteryLevel);
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null);
                        }
                    } else if (call.method.equals("goAboutActivity")) {
                        Intent intent = new Intent(MainActivity.this, AboutActivity.class);
                        MainActivity.this.startActivity(intent);
                        result.success("success");
                    } else {
                        result.notImplemented();
                    }
                });

        new EventChannel(getFlutterView(), STREAM).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        timerSubscription = Observable
                                .interval(0, 1, TimeUnit.SECONDS)
                                .subscribe(
                                        (Long timer) -> {
                                            events.success(timer);// 发送事件
                                        },
                                        (Throwable error) -> {
                                            events.error("STREAM", "EventChannel发生异常", error.getMessage());
                                        }
                                );
                    }

                    @Override
                    public void onCancel(Object args) {
                        if (timerSubscription != null) {
                            timerSubscription.dispose();
                            timerSubscription = null;
                        }
                    }
                }
        );

    }

    private int getBatteryLevel() {
        int batteryLevel;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }

    @Override
    protected void onResume() {
        mapView.onResume();
        super.onResume();
    }

    @Override
    protected void onPause() {
        mapView.onPause();
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        mapView.onDestroy();
        mapView = null;
        super.onDestroy();
    }
}
