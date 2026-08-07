if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    set(GUITERMINAL_BUILD_SHARED ON)
else()
    set(GUITERMINAL_BUILD_SHARED OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mxmauro/GuiTerminal
    REF v0.8.0
    SHA512 5885967b1056264f3a813b47dd799b5a0b76e745d160ebacd36b03761fe158a8bd1d25c5962918c979eedfab5d2b9ef502acc2c18ae8b0656f94fc15349d4de3
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
