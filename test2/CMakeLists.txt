cmake_minimum_required(VERSION 3.16)

project(test2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick Network)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Bluetooth)

set(PROJECT_SOURCES
    main.cpp
    qml.qrc
    pageswitcher.h pageswitcher.cpp
    authhandler.h authhandler.cpp
    blemanager.h blemanager.cpp
    blescanner.h blescanner.cpp
    #bluetoothbaseclass.cpp bluetoothbaseclass.h devicefinder.cpp devicefinder.h deviceinfo.cpp deviceinfo.h
    base64format.h base64format.cpp
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(test2
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )

    # Define target properties for Android with Qt 6 as:
    set_property(TARGET test2 APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
        ${CMAKE_CURRENT_SOURCE_DIR}/android)

    list(APPEND android_extra_libs
        ${CMAKE_CURRENT_SOURCE_DIR}/ui/assets/android_openssl-master/ssl_3/arm64-v8a/libcrypto_3.so
        ${CMAKE_CURRENT_SOURCE_DIR}/ui/assets/android_openssl-master/ssl_3/arm64-v8a/libssl_3.so)

    set_target_properties(test2 PROPERTIES
        QT_ANDROID_EXTRA_LIBS "${android_extra_libs}")

    # For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(test2 SHARED
            ${PROJECT_SOURCES}
        )

        # Define properties for Android with Qt 5 after find_package() calls as:
        set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(test2
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(test2
    PRIVATE Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Bluetooth
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
    set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.test2)
endif()
set_target_properties(test2 PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS test2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(test2)
    qt_policy(SET QTP0002 NEW)
    qt_finalize_executable(test2)
endif()
