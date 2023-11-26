# Use ARM-friendly version of Java
brew install --cask -q zulu

# brew install -q jenv

# export PATH="$HOME/.jenv/bin:$PATH"

# sudo jenv add $(/usr/libexec/java_home)
# sudo jenv add /Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
# jenv global system

# rm -rf ~/.jenv/version
# rm -rf ~/.jenv/versions
# mkdir ~/.jenv/versions
# eval "$(jenv init -)"

# for jenv_p in $(jenv plugins); do
#     jenv enable-plugin $jenv_p
# done

# Set latest java
# latest_Java=$(brew ls zulu | sed "s/ (.*)//" | grep jdk)
# jenv add $latest_Java/Contents/Home
# jenv global $(echo $latest_Java:t | sed "s/\.jdk//" | grep -o -E "[.0-9]+")

# Build Tools
brew install -q maven maven-completion
brew install -q gradle gradle-completion

brew install --cask -q android-platform-tools
brew install --cask -q android-studio

brew install --cask -q android-file-transfer


export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_SDK_TOOLS=$ANDROID_SDK_ROOT/cmdline-tools/tools
mkdir -p $ANDROID_SDK_TOOLS

# Based on https://stackoverflow.com/a/61176718/146656
echo "Android Tools:" &&
    # ANDROID_SDK_TOOLS=$ANDROID_SDK_ROOT/cmdline-tools/tools &&
    homepage=$(curl "https://developer.android.com/studio/index.html") &&
    commandlinetools_url=$(
        echo $homepage |
            pup 'a[href^="https://dl.google.com/android/repository/commandlinetools-mac-"][href$="latest.zip"] attr{href}'
    ) &&
    zipped_filename="android-cmdline-tools" &&
    echo "Downloading and installing $commandlinetools_url as $zipped_filename.zip" &&
    curl -L -C - $commandlinetools_url -o $TEMP_Apps/$zipped_filename.zip --http1.1 &&
    unzip -q -u $TEMP_Apps/$zipped_filename.zip -d $TEMP_Apps/$zipped_filename/ &&
    rm -rf $ANDROID_SDK_TOOLS &&
    mv $TEMP_Apps/$zipped_filename/* $ANDROID_SDK_TOOLS/ &&
    echo "yes" | $ANDROID_SDK_TOOLS/bin/sdkmanager --licenses &&
    $ANDROID_SDK_TOOLS/bin/sdkmanager --install "cmdline-tools;latest" &&
    ANDROID_SDK_TOOLS=$ANDROID_SDK_ROOT/cmdline-tools/latest
export PATH="$ANDROID_SDK_TOOLS/bin:$PATH"
alias sdkmanager="$ANDROID_SDK_TOOLS/bin/sdkmanager"
# Get latest package in format `build-tools;123.45.6` but not `build-tools;124.01.2-rc7`
# It gets all `build-tools;123.45.6 ` (note the space), sorts them, gets latest, then removes the space at the end
echo "yes" | sdkmanager --licenses
echo "yes" | sdkmanager --install "$(
    sdkmanager --list | grep -o "build-tools;\\d\+.\\d\+.\\d\s" | sort --version-sort | tail -1 | grep -o "\S*"
)"
# Get latest `platforms;android-12345`
echo "yes" | sdkmanager --install "$(
    sdkmanager --list | grep -o "platforms;android-\\d\+" | sort --version-sort | tail -1
)"
# Get latest `sources;android-12345`
echo "yes" | sdkmanager --install "$(
    sdkmanager --list | grep -o "sources;android-\\d\+" | sort --version-sort | tail -1
)"
echo "yes" | sdkmanager --install "extras;intel;Hardware_Accelerated_Execution_Manager"
# Get latest Google APIs Intel x86 Atom System Image
# It gets all "google_apis;x86 " (note the space, to avoid "google_apis;x86_64"), then sorts and extracts all non-space part    
echo "yes" | sdkmanager --install "$(
    sdkmanager --list | grep "google_apis;x86\s" | grep -o "system-images\S\+" | sort --version-sort | tail -1
)"
echo "yes" | sdkmanager --update
echo "yes" | sdkmanager --licenses

# TODO:
# Remeber to update Android Studio to use latest $JAVA_HOME, one idea is to have a linked folder called "latest" and set it from this script
# Find a way to automate installing Flutter and Dart plugins into Android Studio

# Required for Flutter
sudo gem install bundler
sudo gem install cocoapods
sudo gem update --system

# echo "yes" | flutter doctor --android-licenses

#Flutter
brew install --cask flutter
flutter upgrade
flutter config --enable-web
flutter doctor
