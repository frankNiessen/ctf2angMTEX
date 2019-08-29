# ctf2ang
Conversion of EBSD file format **ctf** to **ang**.

The program converts the EBSD file format **ctf** HKL orientation files to **ang** TSL orientation files. The conversion requires the input of phase header files. Examples for header files are saved in the subdirectory *data/PhaseHeaders*. These can be edited to describe any other phase.
**Ctf** files for input to the conversion should be placed in subdirectory *data/Input  - ctf*. The converted **ang** files are written into subdirectory *data/Output - ang*.

Brief user instructions to the program are given in the header of the main file *main.m*.
