FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive
ENV IDF_GITHUB_ASSETS dl.espressif.com/github_assets
ENV IDF_PATH /esp-idf
ENV IDF_TOOLS_PATH /esp-idf/tools
ENV ESP_IDF_VERSION v5.3.2
ENV LC_ALL C

WORKDIR /

RUN apt update \
    && apt install -y unzip git curl wget minicom flex bison gperf python3 python3-venv \
        python3-pip locales cmake ninja-build ccache libffi-dev libssl-dev dfu-util \
        libusb-1.0-0 clang-tidy \
    && dpkg-reconfigure locales \
    && apt -y clean \
    && apt -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://${IDF_GITHUB_ASSETS}/espressif/esp-idf/releases/download/${ESP_IDF_VERSION}/esp-idf-${ESP_IDF_VERSION}.zip \
    && unzip -q esp-idf-${ESP_IDF_VERSION}.zip \
    && rm -rf esp-idf-${ESP_IDF_VERSION}.zip \
    && mv esp-idf-${ESP_IDF_VERSION} ${IDF_PATH} \
    && ${IDF_PATH}/install.sh \
    && sh -c "echo \"source ${IDF_PATH}/export.sh\" >> /etc/profile"

