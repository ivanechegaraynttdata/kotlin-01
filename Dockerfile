FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y install --no-install-recommends apt-utils && apt-get -y upgrade && apt-get -y install --no-install-recommends \
  ca-certificates \
  bash \
  curl \
  unzip \
  libasound2 \
  default-jdk

RUN curl -s https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -o /tmp/commandlinetools-linux-9477386_latest.zip && \
  mkdir -p /android-sdk && \
  unzip /tmp/commandlinetools-linux-9477386_latest.zip -d /android-sdk/cmdline-tools && \
  mv /android-sdk/cmdline-tools/cmdline-tools /android-sdk/cmdline-tools/tools && \
  rm -rf /tmp/commandlinetools-linux-9477386_latest.zip

RUN curl -s https://dl.google.com/android/repository/platform-tools_r34.0.3-linux.zip -o /tmp/platform-tools_r34.0.3-linux.zip && \
  unzip /tmp/platform-tools_r34.0.3-linux.zip -d /android-sdk && \
  rm -rf /tmp/platform-tools_r34.0.3-linux.zip

ENV ANDROID_HOME=/android-sdk
ENV PATH=/android-sdk/platform-tools:/android-sdk/cmdline-tools/tools:/android-sdk/cmdline-tools/tools/bin:${PATH}
RUN chmod -R 777 /android-sdk
RUN yes | sdkmanager --licenses

RUN sdkmanager "platforms;android-32"
RUN sdkmanager "platforms;android-33"
RUN sdkmanager "build-tools;33.0.2"
RUN sdkmanager "patcher;v4"
RUN sdkmanager "ndk;25.2.9519653"
RUN sdkmanager "cmake;3.10.2.4988404"