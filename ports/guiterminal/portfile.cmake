if(VCPKG_LIBRARY_LINKAGE STREQUAL ""dynamic"")
    set(GUITERMINAL_BUILD_SHARED ON)
else()
    set(GUITERMINAL_BUILD_SHARED OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mxmauro/GuiTerminal
    REF v0.4.0
    SHA512 c896b97d3fe5461733fda03fc0df0824155494b0cd909685005e005d7ed1284b546d164f3260f33a39a49977fa601a4290222cd5de57ec8b842779e6166a718c
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

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
