<img src="../images/expanse_overview.png" alt="Expanse Overview" width="500px" />

## Expanse Overview:

### HPC for the *long tail* of science:
* Designed by Dell and SDSC delivering 5.16 peak petaflops
* Designed and operated on the principle that the majority of computational research is performed at modest scale: large number jobs that run for less than 48 hours, but can be computationally intensvie and generate large amounts of data.
* An NSF-funded system available through the eXtreme Science and Engineering Discovery Environment (XSEDE) program (https://www.xsede.org).
* Supports interactive computing and science gateways.
* Will offer Composible Systems and Cloud Bursting.


<hr>

<img src="../images/expanse_heterogeneous_arch.png" alt="Expanse Heterogeneous Architecture" width="500px" />

### System Summary

* 13 SDSC Scalable Compute Units (SSCU)
* 728 x 2s Standard Compute Nodes
* 93,184 Compute Cores
* 200 TB DDR4 Memory
* 52x 4-way GPU Nodes w/NVLINK
* 208 V100s | * 4x 2TB Large Memory Nodes
* HDR 100 non-blocking Fabric
* 12 PB Lustre High Performance
* Storage
  * 7 PB Ceph Object Storage
  * 1.2 PB on-node NVMe
* Dell EMC PowerEdge
* Direct Liquid Cooled 


<hr>

### Expanse Scaleable Compute Unit

<img src="../images/expanse_sccu.png" alt="Expanse Scaleable Compute Unit" width="700px" />

<hr>

### Expanse Connectivity Fabric

<img src="../images/expanse_connectivity_fabric.png" alt="Expanse Connectivity Fabric" width="700px" />

<hr>

### AMD EPYC 7742 Processor Architecture
<img src="../images/amd-epyc-7742-processor-arch.png" alt="AMD EPYC 7742 Processor Architecture" width="300px" />


* 8 Core Complex Dies (CCDs). 
* CCDs connect to memory, I/O, and each other through the I/O Die. 
* 8 memory channels per socket. 
* DDR4 memory at 3200MHz. 
* PCI Gen4, up to 128 lanes of high speed I/O. 
* Memory and I/O can be abstracted into separate quadrants each with 2 DIMM channels and 32 I/O lanes. 
* 2 Core Complexes (CCXs) per CCD 
* 4 Zen2 cores in each CCX share a16ML3 cache. Total of 16x16=256MB L3 cache.
* Each core includes a private 512KB L2 cache.  



[Back to Top](#top)
<hr>
