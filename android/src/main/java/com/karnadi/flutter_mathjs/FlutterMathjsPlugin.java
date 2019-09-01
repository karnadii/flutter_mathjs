package com.karnadi.flutter_mathjs;


import org.json.JSONException;
import org.json.JSONObject;
import org.liquidplayer.javascript.JSContext;
import org.liquidplayer.javascript.JSFunction;
import org.liquidplayer.javascript.JSObject;
import org.liquidplayer.javascript.JSValue;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;


/**
 * FlutterMathjsPlugin
 */
public class FlutterMathjsPlugin implements MethodCallHandler {


    private final JSContext context;
    private final JSObject parser;
    private final JSFunction eval;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_mathjs");
        channel.setMethodCallHandler(new FlutterMathjsPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("eval") && call.hasArgument("exp")) {
            String res = eval(call.<String>argument("exp"));
            result.success(res);
        } else if (call.method.equals("help") && call.hasArgument("func")) {
            String res = help(call.<String>argument("func"));
            result.success(res);
        } else if (call.method.equals("format") && call.hasArgument("exp") && call.hasArgument("format")) {
            String res = format(call.<String>argument("exp"), call.<HashMap<String, Object>>argument("format"));
            result.success(res);
        } else if (call.method.equals("clear")) {
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
        eval = parser.property("evaluate").toFunction();

    }

    public String eval(String exp) {
        return eval.call(parser, exp).toString();

    }

    public void clear() {
        JSFunction clear = parser.property("clear").toFunction();
        clear.call(parser);
    }

    public String format(String exp, HashMap formatOpt) {
        JSObject math = context.evaluateScript("math").toObject();
        JSFunction formatF = math.property("format").toFunction();
        List jsParameters = new ArrayList<>();
        try {
            JSONObject json = getJsonFromMap(formatOpt);
            JSValue expStr = eval.call(parser, exp);
            jsParameters.add(expStr);
            jsParameters.add(json);
            String formatted = formatF.call(math, jsParameters.toArray()).toString();
            return formatted;
        } catch (JSONException e) {
            return e.getMessage();
        }

    }

    public String help(String func) {
        String doc = context.evaluateScript("math.help('" + func + "').toJSON()").toJSON();
        return doc;
    }



    private JSONObject getJsonFromMap(Map<String, Object> map) throws JSONException {
        JSONObject jsonData = new JSONObject();
        for (String key : map.keySet()) {
            Object value = map.get(key);
            if (value instanceof Map<?, ?>) {
                value = getJsonFromMap((Map<String, Object>) value);
            }
            jsonData.put(key, value);
        }
        return jsonData;
    }

}

