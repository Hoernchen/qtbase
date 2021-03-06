QT += core-private gui-private platformsupport-private xcb_qpa_lib-private

INCLUDEPATH += $$PWD
INCLUDEPATH += $$PWD/../

# needed by Xcursor ...
qtConfig(xcb-xlib) {
    DEFINES += XCB_USE_XLIB
    qtConfig(xinput2) {
        DEFINES += XCB_USE_XINPUT2
    }
}

# build with session management support
qtConfig(xcb-sm) {
    DEFINES += XCB_USE_SM
}

CONFIG += qpa/genericunixfontdatabase

!qtConfig(system-xcb) {
    DEFINES += XCB_USE_RENDER
    XCB_DIR = $$clean_path($$PWD/../../../../3rdparty/xcb)
    INCLUDEPATH += $$XCB_DIR/include $$XCB_DIR/include/xcb $$XCB_DIR/sysinclude
    LIBS += -L$$MODULE_BASE_OUTDIR/lib -lxcb-static$$qtPlatformTargetSuffix()
    QMAKE_USE += xcb
} else {
    qtConfig(xkb): QMAKE_USE += xcb_xkb
    # to support custom cursors with depth > 1
    qtConfig(xcb-render) {
        DEFINES += XCB_USE_RENDER
    }
    QMAKE_USE += xcb_syslibs
}
