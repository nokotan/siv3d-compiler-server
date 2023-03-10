FROM nokotan/emscripten-compiler-server:latest

COPY sysroot/ /

RUN echo "## Generate .pch file for OpenSiv3D v0.6" \
    && . ${EMSDK}/emsdk_set_env.sh \
    && cd /include/OpenSiv3Dv0.6 \
    && emcc -O0 -fPIC -fvisibility=default -std=c++2a -I/include/OpenSiv3Dv0.6 -I/include/OpenSiv3Dv0.6/ThirdParty -D_XM_NO_INTRINSICS_ Siv3D.hpp -o Siv3D.O0.pch \
    && emcc -O2 -fPIC -fvisibility=default -std=c++2a -I/include/OpenSiv3Dv0.6 -I/include/OpenSiv3Dv0.6/ThirdParty -D_XM_NO_INTRINSICS_ Siv3D.hpp -o Siv3D.O2.pch \
    && emcc -Oz -fPIC -fvisibility=default -std=c++2a -I/include/OpenSiv3Dv0.6 -I/include/OpenSiv3Dv0.6/ThirdParty -D_XM_NO_INTRINSICS_ Siv3D.hpp -o Siv3D.Oz.pch \
    \
    # cleanup
    &&  find ${EMSDK} -name "*.pyc" -exec rm {} \; \
&& echo "## Done"
