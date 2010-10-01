# This file is part of mingw-cross-env.
# See doc/index.html for further information.

# SDL_sound
PKG             := sdl_sound
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.3
$(PKG)_CHECKSUM := 1984bc20b2c756dc71107a5a0a8cebfe07e58cb1
$(PKG)_SUBDIR   := SDL_sound-$($(PKG)_VERSION)
$(PKG)_FILE     := SDL_sound-$($(PKG)_VERSION).tar.gz
$(PKG)_WEBSITE  := http://icculus.org/SDL_sound/
$(PKG)_URL      := http://icculus.org/SDL_sound/downloads/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc sdl libmikmod ogg vorbis smpeg

define $(PKG)_UPDATE
endef

define $(PKG)_BUILD
    $(SED) -i 's,for path in /usr/local; do,for path in; do,' '$(1)/configure'
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --with-sdl-prefix='$(PREFIX)/$(TARGET)' \
        --disable-sdltest \
        --enable-music-mod \
        --enable-music-ogg \
        --disable-music-flac \
        --enable-music-mp3 \
        --disable-music-mod-shared \
        --disable-music-ogg-shared \
        --disable-music-flac-shared \
        --disable-music-mp3-shared \
        --disable-smpegtest \
        --with-smpeg-prefix='$(PREFIX)/$(TARGET)' \
        LIBMIKMOD_CONFIG='$(PREFIX)/$(TARGET)/bin/libmikmod-config' \
        LIBS='-lvorbis -logg'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
