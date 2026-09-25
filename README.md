# Cirrus
## Samtendo account manager for the 3DS

## Usage

1. Grab the latest app and IPS patches from the [Releases](https://github.com/SamtendoNetwork/Cirrus/releases) page
2. Extract to the root of your 3DS SD card
3. Install the Cirrus homebrew using FBI (or FBI Reloaded) if using the CIA build
4. Run the Cirrus homebrew and select either to use a Samtendo or Nintendo account
     - If it doesn't work, reboot your 3DS while holding SELECT and ensure that "Enable loading external FIRMs and modules" and "Enable game patching" are both turned on, as well as ensuring that your Luma3DS version is 13.0 or higher.
5. Enable the Cirrus plugin by entering into the Rosalina menu and setting the "Plugin Loader" to "Enabled"

## Building

1. Clone the repository recursively using `git clone https://github.com/SamtendoNetwork/Cirrus --recursive`
    - If you have cloned the repository previously, please run `git pull` and `make clean` while in the Cirrus folder to avoid errors and broken files
    - On top of that, if you cloned it before 1.0.2 released, you might also need to run `git submodule update --init --recursive` while in the Cirrus folder
2. Install devkitARM, libctru 2.5.0 or later, [CTRPluginFramework](https://gitlab.com/thepixellizeross/ctrpluginframework), [3gxtool](https://gitlab.com/thepixellizeross/3gxtool), [armips](https://github.com/Kingcom/armips), [makerom](https://github.com/3DSGuy/Project_CTR), [bannertool](https://github.com/Steveice10/bannertool) and [flips](https://github.com/Alcaro/Flips)
3. Copy [decompressed `code.bin`](https://github.com/SamtendoNetwork/Cirrus/blob/main/DECOMPRESSING.md) files from the act, friends, http, miiverse, socket and ssl sysmodules in their respective `patches` directories (any Miiverse code.bin works for the miiverse module)
4. Run `make`

## Credits

Thanks to:

- [Sam](https://github.com/sam51210) for maintaining the Samtendo/Cirrus project
- [Aep](https://github.com/Aeplet) for doing most of the work on Cirrus and maintaining the Samtendo/Cirrus project
- [Null](https://github.com/DevNull-l1r) for composing the Cirrus banner theme
- All Nimbus contributors
