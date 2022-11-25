# Dynomite-II
Coleco ADAM Dynomite II Sound Digitizer Cartridge

The Coleco ADAM Dynomite II SDC is a replacement for the rare TriSyd Video Games Dynomite Sound Digitizer cartridge that works with the TriSyd Dynomite Sound
Digitizer software available at http://adamarchive.org/archive/Adam/Drivers/EOS/Dynomite%20Sound%20Digitizer%20%281990%29%20%28Trisyd%20Video%20Games%29.dsk.

As I don't own an original TriSyd Dynomite cartridge and have never seen the circuit used this is not an exact clone of the original but rather a best guess
of how it was designed. This design is based off the Open Amiga Sampler found here https://github.com/echolevel/open-amiga-sampler and modified to work as a
Colecovision cartridge and with the original software.

Prototype testing has been completed and the new Dynomite II works with the original software.

I have uploaded the latest design for the Dynomite II. The Gerber files are in Dynomite_II_SDC_v5_2022-11-23.zip. All of the parts required to build the device
is in the file Bill of Materials.txt. These are all through hole components and are pretty easy to source.

The version 5 design has 2 build options which are described in the Bill of Materials.txt file. The 2 options were to test sound quality. Currently in my
opinion Option 2 produces the clearest sound. If I find any way to improve Option 1 in the future I will update this README.

I used my worst Colecovision cartridge to mount the required RCA jacks and potentiometer. I am working on a 3D printable cartridge design for this project
so hopefully in the future no additional original Colecovision cartridges will need to be sacrificed. 

The ADAM DSK image file /Media/Dynomite Sound Digitizer.dsk is a hacked version of the original TriSyd software with a new title screen and intro sound file
that was recorded and then digitized with the Dynomite II SDC. Other than that the software is the same.
