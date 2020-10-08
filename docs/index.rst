==================================================================
Expanse 101: Introduction to Running Jobs on Expanse Supercomputer
==================================================================
Presented by Mary Thomas (SDSC, mpthomas@ucsd.edu ) .. raw:: html

.. raw:: html

   <hr>

In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: https://github.com/sdsc-hpc-training-org/basic_skills. Menu:
===== Misc Notes/Updates: ——————- - You must have a expanse account in
order to access the system. - To obtain a trial account:
http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts -
You must be familiar with running basic Unix commands: see the following
tutorials at: - https://github.com/sdsc-hpc-training/basic_skills - The
``hostname`` for Expanse is ``expanse.sdsc.edu`` - The operating system
for Expanse was changed to CentOS in December, 2019. As a result, you
will need to recompile all code, some modules and libraries are no
longer needed, and the locations of some libraries and applications have
changed. For details, see the transition guide here: -
https://www.sdsc.edu/services/hpc/expanse_upgrade.html - Our next HPC
system, ``E X P A N S E <https://expanse.sdsc.edu>``\ \__, will be
coming online for early users in September. Keep an eye on the E X P A N
S E pages for training information and other updates If you have any
difficulties completing these tasks, please contact SDSC Consulting
group at consult@sdsc.edu.

.. raw:: html

.. raw:: html

   <hr>

Contents: \* ``Expanse Overview <#overview>``\ \_\_ \*
``Expanse Architecture <#network-arch>``\ \_\_ \*
``Expanse File Systems <#file-systems>``\ \_\_

-  ``Getting Started - Expanse System Environment <#sys-env>``\ \_\_

   -  ``Expanse Accounts <#expanse-accounts>``\ \_\_
   -  ``Logging Onto Expanse <#expanse-logon>``\ \_\_
   -  ``Obtaining Example Code <#example-code>``\ \_\_

-  ``Modules: Managing User Environments <#modules>``\ \_\_

   -  ``Common module commands <#module-commands>``\ \_\_
   -  ``Load and Check Modules and Environment <#load-and-check-module-env>``\ \_\_
   -  ``Module Error: command not found <#module-error>``\ \_\_

-  ``Compiling & Linking <#compilers>``\ \_\_

   -  ``Supported Compiler Types <#compilers-supported>``\ \_\_
   -  ``Using the Intel Compilers <#compilers-intel>``\ \_\_
   -  ``Using the PGI Compilers <#compilers-pgi>``\ \_\_
   -  ``Using the GNU Compilers <#compilers-gnu>``\ \_\_

-  ``Running Jobs on Expanse <#running-jobs>``\ \_\_

   -  ``The SLURM Resource Manager <#running-jobs-slurm>``\ \_\_

      -  ``Common Slurm Commands <#running-jobs-slurm-commands>``\ \_\_
      -  ``Slurm Partitions <#running-jobs-slurm-partitions>``\ \_\_

   -  ``Interactive Jobs using SLURM <#running-jobs-slurm-interactive>``\ \_\_
   -  ``Batch Jobs using SLURM <#running-jobs-slurm-batch-submit>``\ \_\_
   -  ``Command Line Jobs <#running-jobs-cmdline>``\ \_\_

-  ``Hands-on Examples <#hands-on>``\ \_\_
-  ``Compiling and Running GPU/CUDA Jobs <#comp-and-run-cuda-jobs>``\ \_\_

   -  ``GPU Hello World (GPU) <#hello-world-gpu>``\ \_\_

      -  ``GPU Hello World: Compiling <#hello-world-gpu-compile>``\ \_\_
      -  ``GPU Hello World: Batch Script Submission <#hello-world-gpu-batch-submit>``\ \_\_
      -  ``GPU Hello World: Batch Job Output <#hello-world-gpu-batch-output>``\ \_\_

   -  ``GPU Enumeration <#enum-gpu>``\ \_\_

      -  ``GPU Enumeration: Compiling <#enum-gpu-compile>``\ \_\_
      -  ``GPU Enumeration: Batch Script Submission <#enum-gpu-batch-submit>``\ \_\_
      -  ``GPU Enumeration: Batch Job Output <#enum-gpu-batch-output>``\ \_\_

   -  ``CUDA Mat-Mult <#mat-mul-gpu>``\ \_\_

      -  ``Matrix Mult. (GPU): Compiling <#mat-mul-gpu-compile>``\ \_\_
      -  ``Matrix Mult. (GPU): Batch Script Submission <#mat-mul-gpu-batch-submit>``\ \_\_
      -  ``Matrix Mult. (GPU): Batch Job Output <#mat-mul-gpu-batch-output>``\ \_\_

-  ``Compiling and Running CPU Jobs <#comp-and-run-cpu-jobs>``\ \_\_

   -  ``Hello World (MPI) <#hello-world-mpi>``\ \_\_

      -  ``Hello World (MPI): Source Code <#hello-world-mpi-source>``\ \_\_
      -  ``Hello World (MPI): Compiling <#hello-world-mpi-compile>``\ \_\_
      -  ``Hello World (MPI): Interactive Jobs <#hello-world-mpi-interactive>``\ \_\_
      -  ``Hello World (MPI): Batch Script Submission <#hello-world-mpi-batch-submit>``\ \_\_
      -  ``Hello World (MPI): Batch Script Output <#hello-world-mpi-batch-output>``\ \_\_

   -  ``Hello World (OpenMP) <#hello-world-omp>``\ \_\_

      -  ``Hello World (OpenMP): Source Code <#hello-world-omp-source>``\ \_\_
      -  ``Hello World (OpenMP): Compiling <#hello-world-omp-compile>``\ \_\_
      -  ``Hello World (OpenMP): Batch Script Submission <#hello-world-omp-batch-submit>``\ \_\_
      -  ``Hello World (OpenMP): Batch Script Output <#hello-world-omp-batch-output>``\ \_\_

   -  ``Compiling and Running Hybrid (MPI + OpenMP) Jobs <#hybrid-mpi-omp>``\ \_\_

      -  ``Hybrid (MPI + OpenMP): Source Code <#hybrid-mpi-omp-source>``\ \_\_
      -  ``Hybrid (MPI + OpenMP): Compiling <#hybrid-mpi-omp-compile>``\ \_\_
      -  ``Hybrid (MPI + OpenMP): Batch Script Submission <#hybrid-mpi-omp-batch-submit>``\ \_\_
      -  ``Hybrid (MPI + OpenMP): Batch Script Output <#hybrid-mpi-omp-batch-output>``\ \_\_

``Back to Top <#top>``\ \_\_
