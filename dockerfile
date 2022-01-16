FROM ubuntu:focal-20220105

# Install dependencies to download and build source and to handle archives
# tzdata required for cmake and needs to be installed non-interactively
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata \
    && apt-get install -y \
        git \
        tar \
        python3 \
        curl \
        dos2unix \
        cmake \
    && apt-get clean

ENV TOOLCHAIN_PATH=/nilrt-toolchain

# Download and Install the cross compile toolchain for x64 targets
ARG TOOLCHAIN_x64_SHA=c3c4ccf96cc14daea9f350db326b471f817d32740d3b39a3641e7d1cd8056a93
ARG TOOLCHAIN_x64_URL=https://download.ni.com/support/softlib/labview/labview_rt/2018/Linux%20Toolchains/linux/oecore-x86_64-core2-64-toolchain-6.0.sh
RUN curl ${TOOLCHAIN_x64_URL} -Lo install-tc.sh \
    && echo "${TOOLCHAIN_x64_SHA} install-tc.sh" | sha256sum --check --status \
    && chmod +x ./install-tc.sh \
    && ./install-tc.sh -y -d ${TOOLCHAIN_PATH}\
    && rm ./install-tc.sh

# Download and Install the cross compile toolchain for ARM targets
ARG TOOLCHAIN_ARM_SHA=c6e7c560a662b31f45b4c323af9b81ab4bf301f1ccd02066dbe1550e940fcbaa
ARG TOOLCHAIN_ARM_URL=https://download.ni.com/support/softlib/labview/labview_rt/2018/Linux%20Toolchains/linux/oecore-x86_64-cortexa9-vfpv3-toolchain-6.0.sh
RUN curl ${TOOLCHAIN_ARM_URL} -Lo install-tc.sh \
    && echo "${TOOLCHAIN_ARM_SHA} install-tc.sh" | sha256sum --check --status \
    && chmod +x ./install-tc.sh \
    && ./install-tc.sh -y -d ${TOOLCHAIN_PATH}\
    && rm ./install-tc.sh

# Set entrypoint to execute build script
ENTRYPOINT ["/bin/bash"]