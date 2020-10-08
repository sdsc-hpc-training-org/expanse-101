==================================================================
Expanse 101: Introduction to Running Jobs on Expanse Supercomputer
==================================================================
Presented by Mary Thomas (SDSC, mpthomas@ucsd.edu )
.. raw:: html
   <hr>
In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: https://github.com/sdsc-hpc-training-org/basic_skills.
Menu: 
=====
Misc Notes/Updates:
-------------------
-  You must have a expanse account in order to access the system.
   -  To obtain a trial account:
      http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts
-  You must be familiar with running basic Unix commands: see the
   following tutorials at:
   -  https://github.com/sdsc-hpc-training/basic_skills
-  The ``hostname`` for Expanse is ``expanse.sdsc.edu``
-  The operating system for Expanse was changed to CentOS in December,
   2019. As a result, you will need to recompile all code, some modules
   and libraries are no longer needed, and the locations of some
   libraries and applications have changed. For details, see the
   transition guide here:
   -  https://www.sdsc.edu/services/hpc/expanse_upgrade.html
-  Our next HPC system, `E X P A N S E <https://expanse.sdsc.edu>`__,
   will be coming online for early users in September. Keep an eye on
   the E X P A N S E pages for training information and other updates
If you have any difficulties completing these tasks, please contact SDSC
Consulting group at consult@sdsc.edu.

.. raw:: html

   <hr>

Contents: \* `Expanse Overview <#overview>`__ \* `Expanse
Architecture <#network-arch>`__ \* `Expanse File
Systems <#file-systems>`__

-  `Getting Started - Expanse System Environment <#sys-env>`__

   -  `Expanse Accounts <#expanse-accounts>`__
   -  `Logging Onto Expanse <#expanse-logon>`__
   -  `Obtaining Example Code <#example-code>`__

-  `Modules: Managing User Environments <#modules>`__

   -  `Common module commands <#module-commands>`__
   -  `Load and Check Modules and
      Environment <#load-and-check-module-env>`__
   -  `Module Error: command not found <#module-error>`__

-  `Compiling & Linking <#compilers>`__

   -  `Supported Compiler Types <#compilers-supported>`__
   -  `Using the Intel Compilers <#compilers-intel>`__
   -  `Using the PGI Compilers <#compilers-pgi>`__
   -  `Using the GNU Compilers <#compilers-gnu>`__

-  `Running Jobs on Expanse <#running-jobs>`__

   -  `The SLURM Resource Manager <#running-jobs-slurm>`__

      -  `Common Slurm Commands <#running-jobs-slurm-commands>`__
      -  `Slurm Partitions <#running-jobs-slurm-partitions>`__

   -  `Interactive Jobs using SLURM <#running-jobs-slurm-interactive>`__
   -  `Batch Jobs using SLURM <#running-jobs-slurm-batch-submit>`__
   -  `Command Line Jobs <#running-jobs-cmdline>`__

-  `Hands-on Examples <#hands-on>`__
-  `Compiling and Running GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__

   -  `GPU Hello World (GPU) <#hello-world-gpu>`__

      -  `GPU Hello World: Compiling <#hello-world-gpu-compile>`__
      -  `GPU Hello World: Batch Script
         Submission <#hello-world-gpu-batch-submit>`__
      -  `GPU Hello World: Batch Job
         Output <#hello-world-gpu-batch-output>`__

   -  `GPU Enumeration <#enum-gpu>`__

      -  `GPU Enumeration: Compiling <#enum-gpu-compile>`__
      -  `GPU Enumeration: Batch Script
         Submission <#enum-gpu-batch-submit>`__
      -  `GPU Enumeration: Batch Job Output <#enum-gpu-batch-output>`__

   -  `CUDA Mat-Mult <#mat-mul-gpu>`__

      -  `Matrix Mult. (GPU): Compiling <#mat-mul-gpu-compile>`__
      -  `Matrix Mult. (GPU): Batch Script
         Submission <#mat-mul-gpu-batch-submit>`__
      -  `Matrix Mult. (GPU): Batch Job
         Output <#mat-mul-gpu-batch-output>`__

-  `Compiling and Running CPU Jobs <#comp-and-run-cpu-jobs>`__

   -  `Hello World (MPI) <#hello-world-mpi>`__

      -  `Hello World (MPI): Source Code <#hello-world-mpi-source>`__
      -  `Hello World (MPI): Compiling <#hello-world-mpi-compile>`__
      -  `Hello World (MPI): Interactive
         Jobs <#hello-world-mpi-interactive>`__
      -  `Hello World (MPI): Batch Script
         Submission <#hello-world-mpi-batch-submit>`__
      -  `Hello World (MPI): Batch Script
         Output <#hello-world-mpi-batch-output>`__

   -  `Hello World (OpenMP) <#hello-world-omp>`__

      -  `Hello World (OpenMP): Source Code <#hello-world-omp-source>`__
      -  `Hello World (OpenMP): Compiling <#hello-world-omp-compile>`__
      -  `Hello World (OpenMP): Batch Script
         Submission <#hello-world-omp-batch-submit>`__
      -  `Hello World (OpenMP): Batch Script
         Output <#hello-world-omp-batch-output>`__

   -  `Compiling and Running Hybrid (MPI + OpenMP)
      Jobs <#hybrid-mpi-omp>`__

      -  `Hybrid (MPI + OpenMP): Source Code <#hybrid-mpi-omp-source>`__
      -  `Hybrid (MPI + OpenMP): Compiling <#hybrid-mpi-omp-compile>`__
      -  `Hybrid (MPI + OpenMP): Batch Script
         Submission <#hybrid-mpi-omp-batch-submit>`__
      -  `Hybrid (MPI + OpenMP): Batch Script
         Output <#hybrid-mpi-omp-batch-output>`__

`Back to Top <#top>`__

.. raw:: html

   <hr>
Expanse Overview:
-----------------
HPC for the “long tail of science:”
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-  Designed and operated on the principle that the majority of
   computational research is performed at modest scale: large number
   jobs that run for less than 48 hours, but can be computationally
   intensvie and generate large amounts of data.
-  An NSF-funded system available through the eXtreme Science and
   Engineering Discovery Environment (XSEDE) program.
-  Also supports science gateways.
 \* 2.76 Pflop/s peak \* 48,784 CPU cores \* 288 NVIDIA GPUs \* 247 TB
total memory \* 634 TB total flash memory
`Back to Top <#top>`__
