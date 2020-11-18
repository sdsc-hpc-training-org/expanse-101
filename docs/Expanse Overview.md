---
layout: default
title: Expanse Overview
parent: Expanse 101
nav_order: 1
---

# <a name="overview"></a>Expanse Overview:

### HPC for the "long tail of science:"
* Designed and operated on the principle that the majority of computational research is performed at modest scale: large number jobs that run for less than 48 hours, but can be computationally intensvie and generate large amounts of data.
* An NSF-funded system available through the eXtreme Science and Engineering Discovery Environment (XSEDE) program.
* Also supports science gateways.

<img src="images/expanse-rack.png" alt="Expanse Rack View" width="500px" />
* 2.76 Pflop/s peak
* 48,784 CPU cores
* 288 NVIDIA GPUs
* 247 TB total memory
* 634 TB total flash memory


<img src="images/expanse-characteristics.png" alt="Expanse System Characteristics" width="500px" />

[Back to Top](#top)
<hr>

<a name="network-arch"></a><img src="images/expanse-network-arch.png" alt="Expanse Network Architecture" width="500px" />

[Back to Top](#top)
<hr>

<a name="file-systems"></a><img src="images/expanse-file-systems.png" alt="Expanse File Systems" width="500px" />
* Lustre filesystems – Good for scalable large block I/O
* Accessible from all compute and GPU nodes.
* /oasis/scratch/expanse - 2.5PB, peak performance: 100GB/s. Good location for storing large scale scratch data during a job.
* /oasis/projects/nsf - 2.5PB, peak performance: 100 GB/s. Long term storage.
* *Not good for lots of small files or small block I/O.*

* SSD filesystems
* /scratch local to each native compute node – 210GB on regular compute nodes, 285GB on GPU, large memory nodes, 1.4TB on selected compute nodes.
* SSD location is good for writing small files and temporary scratch files. Purged at the end of a job.

* Home directories (/home/$USER)
* Source trees, binaries, and small input files.
* *Not good for large scale I/O.*


[Back to Top](#top)
<hr>
