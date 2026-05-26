if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    set(GUITERMINAL_BUILD_SHARED ON)
else()
    set(GUITERMINAL_BUILD_SHARED OFF)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mxmauro/GuiTerminal
    REF v0.6.1
    SHA512 c9546de2723dba291820f302c4ade8fdf0e92bc8de79b331cbf59306428de1da9f6c6db05c26547b896005b4c139b0b3afccc0eabed6d491633b400d436ce624
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
