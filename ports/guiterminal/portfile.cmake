if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    set(GUITERMINAL_BUILD_SHARED ON)
else()
    set(GUITERMINAL_BUILD_SHARED OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mxmauro/GuiTerminal
    REF v0.10.2
    SHA512 232afae6fc528d86ecfa791a310a5ffd766eaf4df0b2a01263bd8848cd0c492a3695ec22d041fe3f6c90b61e19f8f1055f2d2513f8416befe9df38d2269c21d1
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_SHARED_LIBS=${GUITERMINAL_BUILD_SHARED}
        -DGUITERMINAL_BUILD_DEMO=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/GuiTerminal)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/docs" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
