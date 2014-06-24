SPS-DE
======

Successful-Parent-Selecting Differential Evolution

This project improves the performance of differential evolution with the proposed successful-parent-selecting framework. The introduction of this algorithm can be read in the **Paper**. The simulation results have been preproduced (see **Preproduced Results**). In the **Author's Environments**, the simulation results can be reproduced by running the source codes (see **Reproduce Simulation Results**). The use of the source codes is under the **License** as shown in the final section.

Paper
-----
S.-M. Guo, C.-C. Yang, P.-H. Hsu, and J. S.-H. Tsai, "Improving differential evolution with successful-parent-selecting framework," *under review for IEEE Trans. Evol. Comput.*, 2014.

Preproduced Results
-------------------

* The results of real-world optimization problems are stored in "data/xlsx/CEC11/\*.xlsx" files.
* The results of CEC 2014 optimization problems are stored in "data/xlsx/CEC14\_D10/\*.xlsx", "data/xlsx/CEC14\_D30/\*.xlsx", "data/xlsx/CEC14\_D50/\*.xlsx", and "data/xlsx/CEC14_D100/\*.xlsx", at D = 10, 30, 50, and 100, respectively.
* The figures are stored in "data/figures/\*.pdf" and "data/figures/\*.xlsx".

Author's Environments
---------------------

* Matlab(R) R2012b with all built-in toolbox (to run the MATLAB code)
* Windows 7 or 8 (to run benchmark functions)
* 40GB disk free space (to store the reproduced data)

Reproduce Simulation Results
----------------------------
* Run run.m
* The raw data are stored in "src/\*.mat" files. They are formatted in "src/\*.xlsx" files.

License
-------

* The use of Cauchy random number generator is under the license in "src/cauchy/cauchylicense.txt"
* The CEC 2011 and CEC 2014 benchmark sets are downloaded from http://www.ntu.edu.sg/home/EPNSugan/
* The source codes which appear in "src/*.m" are under the license as shown in the follows.

SPS-DE Successful-Parent-Selecting Differential Evolution
Copyright (C) 2014 Chin-Chang Yang

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA
