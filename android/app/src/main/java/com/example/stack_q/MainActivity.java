package com.example.stack_q;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private MethodChannel channel;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        channel = new MethodChannel(getFlutterEngine().getDartExecutor(), "my-channel");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("login")) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    HashMap<String, String> params = (HashMap<String, String>) call.arguments;
                    HashMap<String, Object> userInfo = new HashMap<>();
                    userInfo.put("name", params.get("name"));
                    userInfo.put("age", params.get("age"));
                    // invoke dart method
                    channel.invokeMethod("loginSuccess", userInfo);
                }
            });
        }
    }
}
