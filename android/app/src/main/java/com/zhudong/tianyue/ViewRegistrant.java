package com.zhudong.tianyue;


import com.amap.api.maps2d.MapView;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;

/**
 * Created by zhudong on 2019/4/28.
 */
public class ViewRegistrant {

    public static void registerWith(PluginRegistry registry, MapView aMapView) {
        final String key = ViewRegistrant.class.getCanonicalName();
        if (registry.hasPlugin(key)) {
            return;
        }

        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("AMapView", new AMapViewFactory(new StandardMessageCodec(), aMapView));
    }
}
