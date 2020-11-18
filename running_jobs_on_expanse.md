# Expanse 101: Introduction to Running Jobs on Expanse Supercomputer

## Presented by Mary Thomas (SDSC, mpthomas@ucsd.edu )
*Thursday, October 8, 2020*

<hr>
In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: https://github.com/sdsc-hpc-training-org/basic_skills.

## Misc Notes/Updates:

*  You must have a expanse account in order to access the system.
  * To obtain a trial account:
      http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts
*  You must be familiar with running basic Unix commands: see the
   following tutorials at:
   *  https://github.com/sdsc-hpc-training/basic_skills
*  The ``hostname`` for Expanse is ``expanse.sdsc.edu``
*  The operating system for Expanse is CentOS
*  For information on moving from Comet to Expanse, see the [Comet to Expanse
Transition Workshpo](https://education.sdsc.edu/training/interactive/202010_comet_to_expanse/index.html)

If you have any difficulties completing these tasks, please contact SDSC
Consulting group at help@xsede.org.

<a name="top">Contents:
* Expanse Overview & Innovative Features
* Getting Started
* Modules
* Account Management
* Compiling and Linking Code
* Running Jobs
* Hands-on Examples
* MPI Jobs
* OpenMP Jobs
* GPU/CUDA Jobs
* Hybrid MPI-OpenMP Jobs 
* Data and Storage, Globus Endpoints, Data Movers, Mount Points
* Final Comments

<!-----
<a name="top">Contents:
* [Expanse Overview](#overview)
    * [Expanse Architecture](#network-arch)
    * [Expanse File Systems](#file-systems)

* [Getting Started - Expanse System Environment](#sys-env)
    * [Expanse Accounts](#expanse-accounts)
    * [Logging Onto Expanse](#expanse-logon)
    * [Obtaining Example Code](#example-code)

* [Modules: Managing User Environments](#modules)
    * [Common module commands](#module-commands)
    * [Load and Check Modules and Environment](#load-and-check-module-env)
    * [Module Error: command not found](#module-error)

* [Compiling & Linking](#compilers)
    * [Supported Compiler Types](#compilers-supported)
    * [Using the Intel Compilers](#compilers-intel)
    * [Using the PGI Compilers](#compilers-pgi)
    * [Using the GNU Compilers](#compilers-gnu)

* [Running Jobs on Expanse](#running-jobs)
    * [The SLURM Resource Manager](#running-jobs-slurm)
      * [Common Slurm Commands](#running-jobs-slurm-commands)
      * [Slurm Partitions](#running-jobs-slurm-partitions)
    * [Interactive Jobs using SLURM](#running-jobs-slurm-interactive)
    * [Batch Jobs using SLURM](#running-jobs-slurm-batch-submit)
    * [Command Line Jobs](#running-jobs-cmdline)

* [Hands-on Examples](#hands-on)
* [Compiling and Running GPU/CUDA Jobs](#comp-and-run-cuda-jobs)
    * [GPU Hello World (GPU) ](#hello-world-gpu)
        * [GPU Hello World: Compiling](#hello-world-gpu-compile)
        * [GPU Hello World: Batch Script Submission](#hello-world-gpu-batch-submit)
        * [GPU Hello World: Batch Job Output](#hello-world-gpu-batch-output)
    * [GPU Enumeration ](#enum-gpu)
        * [GPU Enumeration: Compiling](#enum-gpu-compile)
        * [GPU Enumeration: Batch Script Submission](#enum-gpu-batch-submit)
        * [GPU Enumeration: Batch Job Output](#enum-gpu-batch-output)
    * [CUDA Mat-Mult](#mat-mul-gpu)
        * [Matrix Mult. (GPU): Compiling](#mat-mul-gpu-compile)
        * [Matrix Mult. (GPU): Batch Script Submission](#mat-mul-gpu-batch-submit)
        * [Matrix Mult. (GPU): Batch Job Output](#mat-mul-gpu-batch-output)

* [Compiling and Running CPU Jobs](#comp-and-run-cpu-jobs)
    * [Hello World (MPI)](#hello-world-mpi)
        * [Hello World (MPI): Source Code](#hello-world-mpi-source)
        * [Hello World (MPI): Compiling](#hello-world-mpi-compile)
        * [Hello World (MPI): Interactive Jobs](#hello-world-mpi-interactive)
        * [Hello World (MPI): Batch Script Submission](#hello-world-mpi-batch-submit)
        * [Hello World (MPI): Batch Script Output](#hello-world-mpi-batch-output)
    * [Hello World (OpenMP)](#hello-world-omp)
        * [Hello World (OpenMP): Source Code](#hello-world-omp-source)
        * [Hello World (OpenMP): Compiling](#hello-world-omp-compile)
        * [Hello World (OpenMP): Batch Script Submission](#hello-world-omp-batch-submit)
        * [Hello World (OpenMP): Batch Script Output](#hello-world-omp-batch-output)
    * [Compiling and Running Hybrid (MPI + OpenMP) Jobs](#hybrid-mpi-omp)
        * [Hybrid (MPI + OpenMP): Source Code](#hybrid-mpi-omp-source)
        * [Hybrid (MPI + OpenMP): Compiling](#hybrid-mpi-omp-compile)
        * [Hybrid (MPI + OpenMP): Batch Script Submission](#hybrid-mpi-omp-batch-submit)
        * [Hybrid (MPI + OpenMP): Batch Script Output](#hybrid-mpi-omp-batch-output)

[Back to Top](#top)
<hr>
----->
