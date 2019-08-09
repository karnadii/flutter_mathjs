package com.karnadi.flutter_mathjs;

import org.liquidplayer.javascript.JSContext;
import org.liquidplayer.javascript.JSFunction;
import org.liquidplayer.javascript.JSObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.Scanner;


/**
 * FlutterMathjsPlugin
 */
public class FlutterMathjsPlugin implements MethodCallHandler {


    final JSContext context;
    final JSObject parser;
    final JSFunction eval;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_mathjs");
        channel.setMethodCallHandler(new FlutterMathjsPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("eval") && call.hasArgument("exp")) {
            result.success(eval(call.<String>argument("exp")));
        } if (call.method.equals("clear")) {
            clear();
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    public FlutterMathjsPlugin() {
        context = new JSContext();
        InputStream stream = FlutterMathjsPlugin.class.getResourceAsStream("/math.min.js");
        final String mathString = new Scanner(stream, Charset.defaultCharset().name())
                .useDelimiter("\\A").next();
        context.evaluateScript(mathString);
        parser = context.evaluateScript("math.parser()").toObject();
        eval = parser.property("eval").toFunction();
    }

    public String eval(String exp) {
        return eval.call(parser, exp).toString();
    }

    public void clear() {
        JSFunction clear = parser.property("clear").toFunction();
        clear.call();
    }

}
