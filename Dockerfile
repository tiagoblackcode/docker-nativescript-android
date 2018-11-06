FROM node:10-stretch

# java 8
RUN apt-get update && \
    apt-get install -y unzip openjdk-8-jdk-headless

# android sdk tools
RUN cd /tmp && \
    wget --quiet https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip -q sdk* && \
    mkdir -p /android-sdk && \
    mv tools /android-sdk/tools && \
    cd /android-sdk && \
    yes | tools/bin/sdkmanager --licenses && \
    tools/bin/sdkmanager \
        "tools" \
        "platform-tools" \
        "platforms;android-27" \
        "build-tools;27.0.0" \
        "extras;google;m2repository" \
        "extras;android;m2repository"

# nativescript
RUN npm install -g nativescript@4.2 && \
    tns usage-reporting disable && \
    tns error-reporting enable

ENV ANDROID_HOME=/android-sdk
