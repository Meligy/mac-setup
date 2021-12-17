# macOS Setup Script & Dotfiles By [@Meligy](https://twitter.com/meligy)

This code has two main parts:

- A script that sets up a Mac
- A set of dotfiles that get linked to the user folder

It's for personal use, but shared for benefit and learning.

## Setting Up

To install, start a ZSH terminal in this directory and run the following in it:

```zsh
zsh -l ./build-machine.sh && exec zsh -l
```

Optionally, relace `zsh` with  `zsh -e` if you want the script to attempt to stop at the first failure (doesn't always work, but worked enough in my experience while trying to get the script to work on a clean ARM-based machine). I'll probably make this the default in the future.

### Clean Up

The scripts cache some installers in the `temp/apps` directory. It's helpful in debug situations and the cache is smart enough to not get used instead of the latest version. But you can always delete the cache by deleting this folder or running `git clean -dfx`.

## Implementation Details & Design Decisions

### Scripts

- This is for personal use, prefer simple solutions over scalable ones
- dotfiles are in the same repository for simplicity
- The script is designed for macOS Monterey, where `zsh` is the default terminal already, so it uses it
- No excessive checks to avoid output warnings. If we install something and get a warning that it's installed already, that's fine
- The script is idempotent. It can be run several times without issues. Typically I'll run the whole script whenever I add a new app etc (but the messages might be silly as per the previous point)
- Tools that have sync do not require scripts. For example, no VS Code or Chromium browsers settings / customizations, or extensions, as these apps have profile sync
- Try to split the script into logical groups whenever possible
- Some interactive screens will come up during setup, for example, `jenv` accessing `Android Studio` might say it's downloaded from the internet. These are hard to test after the fact, so they are accepted as-is for now.
    - You'll need to watch the script in case it needs manual intervention
    - Even though I try to reduce this. `brew` does not require it for example, `sudo` commands should just work after initial prompt
    - In short, I did my best to avoid these cases, but I cannot -and do not- guarantee that

### Dotfiles
- The `.zprofile` file should be light to be used everywhere
- The `.zshrc` should have the rest stuff that's to be used for interactive terminal

## Known Issues

- **This is currently only tested on and optimised for Intel-based Mac running latest macOS**.
  ### ARM Support Progress
    - ✅ Detect ARM Mac and install Rosetta when detected (Intel-based apps support)
    - ⬜️ Check if this needs to do anything special for homebrew
    - ⬜️ Check if this should use a different version of JVM, like Azul JSM (as suggested in [this video](https://www.youtube.com/watch?v=dCbr2iFbh8o))
    - ... TBA (unknown unknowns)
- Due to tolerance to long output, sometimes it can be difficult to see when a certain step has failed (consider adding `-e` to the `zsh` command to try and fail on first error)
- Since the utility is mainly for my personal use, some commercial apps are also in the script, with the following limitations:
    - If you purchased the apps, you'll need to enter the keys manually. No support for entering these for you from a `.gitignored`d file or similar process
    - No separation between free and paid apps, or a "--free-only" option at the moment
    - Here are the apps that I do remember them requiring a purchase (I haven't checked the whole list):
        - SnagIt
        - Battery Health 3
        - Parallels Desktop
- Just like a license, if an app requires login etc, this is all done manually now
- The Mac settings that are scripted are much less than can be done
- The shell reloading logic near the end might be too much
- Some apps require modifying the Accessibility permissions, like Snagit. These were not all scripted
- There are still cases that will ask for your admin password/fingerprint in the middle of the script run
    - dotnet certificate install will ask twice
    - First insntall of finderpath will ask for it too in addition to requesting accessibility permissions as well
- Sometimes the script would hang after showing your account in app store (managed by the "mas" utility)
    - This only happened after upgrade to Big Sur, when the user was shown as still logged in to App store. It seems to happen when you are logged in to the App Store then you upgrade your macOS and it goes to a funny signed-in-but-not-really state.
    - To Keep Going (Seems non harmful, not 100% sure):
        - Open App Store
        - There should be a message saying "Redownload Unavailable with This Apple ID"
        - Click "OK", the message will go away, and the script will continue
        - If you get an error message in the next step (Xcode install), and just make sure you have latest Xcode in the App Store
    - Other Things To Try
        - Ensure XCode is closed if it's open
        - Quit App Store, dismiss the "Redownload Unavailable with This Apple ID" dialog if it's showing
        - Go to System Preferences -> Apple ID
        - In the Overview section, click "Sign out", and proceed with signing out
        - Sign in to Apple ID again
        - Open App Store and sign in again
        - Quit the Terminal app just in case, and then open it again and rerun the script
        - If the script shows that you are not logged in even though you are, just press Enter/Return to continue, and ignore the message about being not logged in from the next step (Xcode install), and just make sure you have latest Xcode in the App Store
        <!-- This also didn't help:
        - Go to System Preference, then Security & Privacy, then the Privacy tab, then from the left click "Developer Tools". Find the Terminal app in the list on the right and check its checkbox -->
- At the moment the code quality could use a lot of improvements, namely, there are a lot of comments that can be deleted

### Specific Missing Apps / Configurations

- Some apps are very handy, but their maintainers do not want their download scripted. So, the following apps should be downloaded manually
    - [Audacity](https://www.audacityteam.org/download/mac/)
        - **Update:** It looks like it's now available via Github releases, but the script has not been updated yet
- Android Studio
    - If you are doing Flutter development, you need to install the Flutter plug-in manually. I have not found a way to automate installing it yet.
    - In first time wizard, you should choose manual setup and use the Java version in `$JAVA_HOME`. The Android SDK components should be all installed already, but I compared them manually on 22/02/2020. Any new recommended Android SDK component (not new version, that's covered in script), you might need to download it from this wizard.
    - You might also want to check the Java version matches what's in `$JAVA_HOME` after several Java updates if you want to use the latest

## Other Projects Tackling Mac Setup

The internet is full of projects that take on the same problem, in kinda-similar kinda-different ways. For example:

- https://github.com/jon-van/Setup_macOS
- https://gist.github.com/bradp/bea76b16d3325f5c47d4
- https://github.com/pathikrit/mac-setup-script
- https://github.com/mathiasbynens/dotfiles/

If you are looking to see what settings people tweak as well, here are some examples:

- https://gist.github.com/smgt/3227665
- https://gist.github.com/marshall007/2311524
- https://github.com/mathiasbynens/dotfiles/blob/master/.macos
