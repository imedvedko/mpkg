#
# MOPSLinux packaging system
#
#
cmake_minimum_required(VERSION 2.4)
    if(COMMAND cmake_policy)
      cmake_policy(SET CMP0003 NEW)
    endif(COMMAND cmake_policy)
# Project name
PROJECT(LIBMPKG_PARTED)

# Enabling building of shared libs
SET(BUILD_SHARED_LIBS ON)

# Check 64 bit
if (CMAKE_SIZEOF_VOID_P EQUAL 4)
	SET(X86_64 OFF)
else (CMAKE_SIZEOF_VOID_P EQUAL 4)
	SET(X86_64 ON)
	ADD_DEFINITIONS(-DX86_64)
endif(CMAKE_SIZEOF_VOID_P EQUAL 4)

# Compilation definitions.
ADD_DEFINITIONS(-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -DLARGEFILE64_SOURCE -DDL_CLEANUP -Wall -W -DNEW_INSTALL_SYSTEM -DUSE_SYSTEM_SED -DDEP_NORMALIZE -DLINUX_DEFINED)
ADD_DEFINITIONS(${CXXFLAGS})

ADD_LIBRARY(mpkg-parted SHARED mpkg-parted raidtool lvmtool)
TARGET_LINK_LIBRARIES(mpkg-parted mpkgsupport parted)
#ADD_LIBRARY(mpkg SHARED menu terminal package bus dbstruct HttpDownload errorcodes DownloadManager PackageConfig conditions config constants converter core dataunits debug dependencies libmpkg local_package mpkg mpkgsys repository sql_pool syscommands xmlParser htmlcore tests metaframe)
#TARGET_LINK_LIBRARIES(mpkg xml2 curl sqlite3 mpkgsupport mpkgcurses)
ADD_EXECUTABLE(test test)
TARGET_LINK_LIBRARIES(test mpkg-parted)

FILE(GLOB files "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
INSTALL(FILES ${files} DESTINATION include/mpkg-parted)
IF(X86_64)
	INSTALL(TARGETS mpkg-parted
		RUNTIME DESTINATION bin
		LIBRARY DESTINATION lib64
		ARCHIVE DESTINATION lib64
	)
ELSE(X86_64)
	INSTALL(TARGETS mpkg-parted
		RUNTIME DESTINATION bin
		LIBRARY DESTINATION lib
		ARCHIVE DESTINATION lib
	)
ENDIF(X86_64)
