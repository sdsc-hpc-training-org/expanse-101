
# Expanse 101:  Introduction to Running Jobs on the Expanse Supercomputer
Presented by Mary Thomas (SDSC,  <mpthomas@ucsd.edu> )
<hr>
In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: [Basic HPC Skills](https://github.com/sdsc-hpc-training-org/basic_skills).

# Misc Notes/Updates:
*  You must have a expanse account in order to access the system.
  * To obtain a trial account:
      [Comet trial account](http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts)
*  You must be familiar with running basic Unix commands: see the
   following tutorials at:
   *  [https://github.com/sdsc-hpc-training/basic_skills](https://github.com/sdsc-hpc-training/basic_skills)
*  The ``hostname`` for Expanse is ``expanse.sdsc.edu``
*  The operating system for Expanse is CentOS
*  For information on moving from Comet to Expanse, see the [Comet to Expanse
Transition Workshop](https://education.sdsc.edu/training/interactive/202010_comet_to_expanse/index.html)

If you have any difficulties completing these tasks, please contact SDSC
Consulting group at help@xsede.org.

<a name="top">Contents:
* [Expanse Overview & Innovative Features](#overview)
* [Getting Started](#get-start)
  * [Obtaining Expanse Accounts](#get-start-expanse-accounts)
  * [Logging Onto Expanse](#get-start-expanse-logon)
  * [Obtaining Example Code](#get-start-example-code)
  * [Expanse User Portal](#get-start-user-portal)
* [Modules](#modules)
   * [Loading Modules During Login](#module-login-load)
   * [Modules: Popular Lmod Commands](#module-commands)
   * [Loading Modules During Login](#module-login-load)
   * [Troubleshooting:Module Error](#module-error)
* [Managing Accounts](#managing-accounts)
   * [Expanse Client Script](#manage-accts-client-script)
   * [Using Accounts in Batch Jobs](#manage-accts-batch-script)
   * [Managing Users on an Account](#manage-accts-users)  
* [Job Charging](#job-charging)
* [Compiling & Linking](#compilers)
   * [Supported Compilers](#compilers-supported")
   * [AMD Optimizing C/C++ Compiler (AOCC)](#compilers-amd)
   * [Intel Compilers](#compilers-intel)
   * [GNU Compilers](#compilers-gnu)
   * [PGI Compilers](#compilers-pgi)
* [Running Jobs](#run-jobs)
   * [Parallel Models](#run-jobs-par-models)
   * [Methods for  Running Jobs on Expanse](#run-jobs-methods)
      * [Batch Jobs](#run-jobs-methods-batch)
      * [Interactive Jobs](#run-jobs-methods-ineractive)
   * [SLURM Resource Manager](#run-jobs-slurm)
      * [SLURM Partitions](#run-jobs-slurm-partition)
      * [SLURM Commands](#run-jobs-slurm-commands)
      * [SLURM Batch Script Example](#run-jobs-slurm-batch)
* [Compiling and Running CPU Jobs](#comp-and-run-cpu-jobs)
   * [Hello World (MPI)](#hello-world-mpi)
        * [Hello World (MPI): Source Code](#hello-world-mpi-source)
        * [Hello World (MPI): Compiling](#hello-world-mpi-compile)
        * [Hello World (MPI): Batch Script Submission](#hello-world-mpi-batch-submit)
        * [Hello World (MPI): Batch Script Output](#hello-world-mpi-batch-output)
        * [Hello World (MPI): Interactive Jobs](#hello-world-mpi-interactive)
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
* [Compiling and Running GPU Jobs](#comp-run-gpu)
   * [Using Expanse GPU Nodes](#comp-run-gpu-nodes)
   * [Using Interactive GPU Nodes](#comp-run-gpu-interactive)
   * [Hello World (GPU)](#hello-world-gpu)
       * [Hello World (GPU): Source Code](#hello-world-gpu-source)
       * [Hello World (GPU): Compiling](#hello-world-gpu-compile)
       * [Hello World (GPU): Batch Script Submission](#hello-world-gpu-batch-submit)
       * [Hello World (GPU): Batch Script Output](#hello-world-gpu-batch-output)
* Data and Storage, Globus Endpoints, Data Movers, Mount Points
* Final Comments

<hr>

<img src="images/expanse_overview.png" alt="Expanse Overview" width="500px">

## Expanse Overview <a name="overview"></a>

### HPC for the *long tail* of science:
* Designed by Dell and SDSC delivering 5.16 peak petaflops
* Designed and operated on the principle that the majority of computational research is performed at modest scale: large number jobs that run for less than 48 hours, but can be computationally intensvie and generate large amounts of data.
* An NSF-funded system available through the eXtreme Science and Engineering Discovery Environment (XSEDE) program (https://www.xsede.org).
* Supports interactive computing and science gateways.
* Will offer Composible Systems and Cloud Bursting.


<hr>

<img src="images/expanse_heterogeneous_arch.png" alt="Expanse Heterogeneous Architecture" width="500px">

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

<img src="images/expanse_sccu.png" alt="Expanse Scaleable Compute Unit" width="700px">

<hr>

### Expanse Connectivity Fabric

<img src="images/expanse_connectivity_fabric.png" alt="Expanse Connectivity Fabric" width="700px" />

<hr>

### AMD EPYC 7742 Processor Architecture
<img src="images/amd-epyc-7742-processor-arch.png" alt="AMD EPYC 7742 Processor Architecture" width="300px" />


* 8 Core Complex Dies (CCDs).
* CCDs connect to memory, I/O, and each other through the I/O Die.
* 8 memory channels per socket.
* DDR4 memory at 3200MHz.
* PCI Gen4, up to 128 lanes of high speed I/O.
* Memory and I/O can be abstracted into separate quadrants each with 2 DIMM channels and 32 I/O lanes.
* 2 Core Complexes (CCXs) per CCD
* 4 Zen2 cores in each CCX share a16ML3 cache. Total of 16x16=256MB L3 cache.
* Each core includes a private 512KB L2 cache.  

<hr>
### New Expanse Features 

#### Composable Systems

<img src="images/expanse_composable_systems.png" alt="Expanse Composable Systems" width="400px" />
Composable Systems will support complex, distributed, workflows – making Expanse part of a larger CI ecosystem.

* Bright Cluster Manager + Kubernetes
* Core components developed via NSF- funded CHASE-CI (NSF Award # 1730158), and the Pacific Research Platform (NSF Award # 1541349)
* Requests for a composable system will be part of an XRAC request
* Advanced User Support resources available to assist with projects - this is part of our operations funding.
  *  Webinar scheduled for April 2021. See: https://www.sdsc.edu/education_and_training/training_hpc.html


#### Cloud Bursting
Expanse will support integration with public clouds:

  <img src="images/expanse_cloud_burst_aws.png" alt="Expanse Cloud Bursting to AWS" width="400px" />

* Supports projects that share data, need access to novel technologies, and integrate cloud resources into workflows
* Slurm + in-house developed software + Terraform (Hashicorp)
* Early work funded internally and via NSF E-CAS/Internet2 project for CIPRES (Exploring Cloud for the Acceleration of Science, Award #1904444).
* Approach is cloud-agnostic and will support the major cloud providers.
* Users submit directly via Slurm, or as part of a composed system.
* Options for data movement: data in the cloud; remote mounting of file systems; cached filesystems (e.g., StashCache), and data transfer during the job.
* Funding for users cloud resources is not part of an Expanse award: the researcher must have access to cloud computing credits via other NSF awards and funding.


[Back to Top](#top)
<hr>



## <a name="get-start"></a>Getting Started on Expanse
In this Section:
* [Expanse Accounts](#get-start-expanse-accounts)
* [Logging Onto Expanse](#get-start-expanse-logon)
* [Obtaining Example Code](#get-start-example-code)
* [Expanse User Portal](#get-start-user-portal)


[Back to Top](#top)
<hr>ba

### Expanse Accounts<a name="get-start-expanse-accounts"></a>
You must have a expanse account in order to access the system.
* Obtain a trial account here:  [http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts](http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts)
    * You can use your existing XSEDE account.


### Logging Onto Expanse<a name="get-start-expanse-logon"></a>

Expanse supports Single Sign-On through the [XSEDE User Portal](https://portal.xsede.org), from the command line using an XSEDE-wide password (coming soon, the Expanse User Portal). While CPU and GPU resources are allocated separately, the login nodes are the same. To log in to Expanse from the command line, use the hostname:

```
login.expanse.sdsc.edu
```

The following are examples of Secure Shell (ssh) commands that may be used to log in to Expanse:

```
ssh <your_username>@login.expanse.sdsc.edu
ssh -l <your_username> login.expanse.sdsc.edu
```
Details about how to access Expanse under different circumstances are described in the Expanse User Guide:
https://www.sdsc.edu/support/user_guides/expanse.html#access

For instructions on how to use SSH,
see [Connecting to SDSC HPC Systems Guide](https://github.com/sdsc-hpc-training-org/hpc-security/tree/master/connecting-to-hpc-systems). Below is the logon message – often called the *MOTD* (message of the day, located in /etc/motd). This has not been implemented at this point on Expanse

```
[username@localhost:~] ssh -Y expanse.sdsc.edu
Welcome to Bright release         9.0

                                                        Based on CentOS Linux 8
                                                                    ID: #000002

--------------------------------------------------------------------------------

                                 WELCOME TO
                  _______  __ ____  ___    _   _______ ______
                 / ____/ |/ // __ \/   |  / | / / ___// ____/
                / __/  |   // /_/ / /| | /  |/ /\__ \/ __/
               / /___ /   |/ ____/ ___ |/ /|  /___/ / /___
              /_____//_/|_/_/   /_/  |_/_/ |_//____/_____/

--------------------------------------------------------------------------------

Use the following commands to adjust your environment:

'module avail'            - show available modules
'module add <module>'     - adds a module to your environment for this session
'module initadd <module>' - configure module to be loaded at every login

-------------------------------------------------------------------------------
Last login: Fri Nov 1 11:16:02 2020 from 76.176.117.51
```

#### Example of a terminal connection/Unix login session:

```
localhost:~ username$ ssh -l username login.expanse.sdsc.edu
Last login: Wed Oct  7 11:04:17 2020 from 76.176.117.51
[username@login02 ~]$
[username@login02 ~]$ whoami
username
[username@login02 ~]$ hostname
login01
[username@login02 ~]$ pwd
/home/username
[username@login02 ~]$
```
[ [Back to Getting Started](#get-start) ] [ [Back to Top](#top) ]
<hr>

### Obtaining Tutorial Example Code<a name="get-start-example-code"></a>
We will be clone the example code from GitHub repository located here:
https://github.com/sdsc-hpc-training-org/expanse-101

The example below will be for anonymous HTTPS downloads

* Create a test directory hold the expanse example files (optional):
*
```
[username@login01 TEMP]$ git clone https://github.com/sdsc-hpc-training-org/expanse-101.git
Cloning into 'expanse-101'...
remote: Enumerating objects: 275, done.
remote: Counting objects: 100% (275/275), done.
remote: Compressing objects: 100% (217/217), done.
remote: Total 784 (delta 163), reused 122 (delta 55), pack-reused 509
Receiving objects: 100% (784/784), 12.98 MiB | 20.92 MiB/s, done.
Resolving deltas: 100% (434/434), done.
Checking out files: 100% (56/56), done.
[username@login01 TEMP]$ cd expanse-101/
[username@login01 expanse-101]$ ll
total 8784
drwxr-xr-x 6 username abc123       11 Jan 28 22:39 .
drwxr-xr-x 3 username abc123        3 Jan 28 22:39 ..
-rw-r--r-- 1 username abc123     6148 Jan 28 22:39 .DS_Store
drwxr-xr-x 8 username abc123       8 Jan 28 22:39 examples
-rw-r--r-- 1 username abc123    76883 Jan 28 22:39 Expanse_Aggregate.md
drwxr-xr-x 8 username abc123       13 Jan 28 22:39 .git
-rw-r--r-- 1 username abc123      457 Jan 28 22:39 .gitignore
drwxr-xr-x 2 username abc123       16 Jan 28 22:39 images
-rw-r--r-- 1 username abc123     3053 Jan 28 22:39 README.md
-rw-r--r-- 1 username abc123  8855428 Jan 28 22:39 Webinar-Running-Jobs-on-Expanse-10-08-2020.pdf
```

*Note*: you can learn to create and modify directories as part of the *Getting Started* and *Basic Skills* preparation found here:
https://github.com/sdsc-hpc-training-org/basic_skills

The examples directory contains the code we will cover in this tutorial:

```
[username@login01 examples]$ ll
total 141
drwxr-xr-x 9 username abc123  9 Jan 28 22:44 .
drwxr-xr-x 5 username abc123  10 Jan 28 22:44 ..
drwxr-xr-x 6 username abc123   7 Jan 28 22:44 CUDA
drwxr-xr-x 6 username abc123   7 Jan 28 22:39 cuda-samples
drwxr-xr-x 2 username abc123   3 Jan 28 22:39 ENV_INFO
drwxr-xr-x 2 username abc123   6 Jan 28 22:39 HYBRID
drwxr-xr-x 2 username abc123   6 Jan 28 22:39 MPI
drwxr-xr-x 2 username abc123   6 Jan 28 22:39 OpenACC
drwxr-xr-x 2 username abc123   6 Jan 28 22:39 OPENMP

```
All examples will contain source code, along with a batch script example so you can compile and run all examples on Expanse.

[ [Back to Getting Started](#get-start) ] [ [Back to Top](#top) ]
<hr>

### Expanse User Portal<a name="get-start-user-portal"></a>
<img src="images/expanse_user_portal.png" alt="Expanse User Portal" width="400px" />

* See: https://portal.expanse.sdsc.edu
* Quick and easy way for Expanse users to login, transfer and edit files and submit and monitor jobs.
* Gateway for launching interactive applications such as MATLAB, Rstudio
* Integrated web-based environment for file management and job submission.
* All Users with valid Expanse Allocation and XSEDE Based credentials have access via their XSEDE credentials..

[ [Back to Getting Started](#get-start) ] [ [Back to Top](#top) ]
<hr>


## <a name="modules"></a>Environment Modules: Customizing Your User Environment
The Environment Modules package provides for dynamic modification of your shell environment. Module commands set, change, or delete environment variables, typically in support of a particular application. They also let the user choose between different versions of the same software or different combinations of related codes. See the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#modules).

In this Section:
* [Introduction to the Lua Lmod Module System](#module-lmod-intro)
* [Modules: Popular Lmod Commands](module-commands)
* [Load and Check Modules and Environment](#load-and-check-module-env)

<!----
* [Module Error: command not found](#module-error)
---->

[Back to Top](#top)
<hr>

### Introduction to the Lua Lmod Module System<a name="module-lmod-intro"></a>
* Expanse uses Lmod, a Lua based module system.
   * See: https://lmod.readthedocs.io/en/latest/010_user.html
* Users setup custom environments by loading available modules into the shell environment, including needed compilers and libraries and the batch scheduler.
* What’s the same as Comet:
  * Dynamic modification of your shell environment
  * User can set, change, or delete environment variables
  * User chooses between different versions of the same software or different combinations of related codes.
* Modules: What’s Different?
  * *Users will need to load the scheduler (e.g. slurm)*
  * Users will not see all available modules when they run command "module available" without loading a compiler.
  * Use the command "module spider" option to see if a particular package exists and can be loaded, run command
      * module spider <package>
      * module keywords <term>
  * For additional details, and to identify module dependencies modules, use the command
      * module spider <application_name>
  * The module paths are different for the CPU and GPU nodes. Users can enable the paths by loading the following modules:               
      * module load cpu  (for cpu nodes)
      * module load gpu  (for gpu nodes)  
      * note: avoid loading both modules

[ [Back to Modules](#modules) ] [ [Back to Top](#top) ]
<hr>

### Modules: Popular Lmod Commands<a name="module-commands"></a>

Here are some common module commands and their descriptions:

| Lmod Command | Description |
|:--- | :--- |
|module list|List the modules that are currently loaded|
|module avail|List the modules that are available in environment|
|module spider|List of the modules and extensions currently available|
|module display <module_name>|Show the environment variables used by
<module name> and how they are affected|
|module unload <module name>|Remove <module name> from the environment|
|module load <module name>|Load <module name> into the environment|
|module swap <module one> <module two>|Replace <module one> with
<module two> in the environment|
|module help|get a list of all the commands that module knows about do:

Lmod commands support *short-hand* notation, for example:

```
   ml foo == module load foo
   ml -bar”  == module unload bar
```
*SDSC Guidance:   add module calls to your environment and batch scripts*



<b> A few module command examples:</b>

* Default environment for a new user/new login: `list`, `li`

```
(base) [username@login01 expanse-101]$ module list
Currently Loaded Modules:
1) shared   2) slurm/expanse/20.02.3   3) cpu/0.15.4   4) DefaultModules
```

* List available modules:  `available`, `avail`, `av`

```
$ module av
[username@expanse-ln3:~] module av
(base) [username@login01 expanse-101]$ module available

--------------- /cm/shared/apps/spack/cpu/lmod/linux-centos8-x86_64/Core ----------------
   abaqus/2018     gaussian/16.C.01        gmp/6.1.2           mpfr/4.0.2
   aocc/2.2.0      gcc/7.5.0               intel/19.1.1.217    openjdk/11.0.2
   cmake/3.18.2    gcc/9.2.0               libtirpc/1.2.6      parallel/20200822
   emboss/6.6.0    gcc/10.2.0       (D)    matlab/2020b        subversion/1.14.0

--------------------------------- /cm/local/modulefiles ---------------------------------
   cluster-tools-dell/9.0        gcc/9.2.0                    null
   cluster-tools/9.0             gpu/1.0                      openldap
   cmd                           ipmitool/1.8.18              python3
   cmjob                         kubernetes/expanse/1.18.8    python37
   cpu/1.0                (L)    lua/5.3.5                    shared                (L)
   docker/19.03.5                luajit                       singularitypro/3.5
   dot                           module-git                   slurm/expanse/20.02.3
   freeipmi/1.6.4                module-info

-------------------------------- /usr/share/modulefiles ---------------------------------
   DefaultModules (L)    gct/6.2    globus/6.0

-------------------------------- /cm/shared/modulefiles ---------------------------------
   bonnie++/1.98                default-environment           netperf/2.7.0
   cm-pmix3/3.1.4               gdb/8.3.1                     openblas/dynamic/0.3.7
   cuda10.2/blas/10.2.89        hdf5/1.10.1                   openmpi/gcc/64/1.10.7
   cuda10.2/fft/10.2.89         hdf5_18/1.8.21                sdsc/1.0
   cuda10.2/nsight/10.2.89      hwloc/1.11.11                 ucx/1.6.1
   cuda10.2/profiler/10.2.89    iozone/3_487
   cuda10.2/toolkit/10.2.89     netcdf/gcc/64/gcc/64/4.7.3

  Where:
   L:  Module is loaded
   D:  Default Module

```

*Note:* Module defaults are chosen based on Find First Rules due to Name/Version/Version modules found in the module tree.
See https://lmod.readthedocs.io/en/latest/060_locating.html for details.

Use ```module spider``` to find all possible modules and extensions.

```
(base) [username@login02 ~]$ module spider MPI
-------------------------------------------------------------------------------------
  intel-mpi: intel-mpi/2019.8.254
-------------------------------------------------------------------------------------
    You will need to load the set of module(s) on any one of the lines below before the "intel-mpi/2019.8.254" module is available to load.

      cpu/1.0  gcc/10.2.0
      cpu/1.0  intel/19.1.1.217
      gpu/1.0
      gpu/1.0  intel/19.0.5.281
      gpu/1.0  pgi/20.4

    Help:
      Intel MPI
-------------------------------------------------------------------------------------
  openmpi:
-------------------------------------------------------------------------------------
     Versions:
        openmpi/3.1.6
        openmpi/4.0.4-nocuda
        openmpi/4.0.4
-------------------------------------------------------------------------------------
  For detailed information about a specific "openmpi" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider openmpi/4.0.4
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
  openmpi/gcc/64: openmpi/gcc/64/1.10.7
-------------------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "openmpi/gcc/64/1.10.7" module is available to load.
      shared
    Help:
        Adds OpenMPI to your environment variables,      
```

[ [Back to Modules](#modules) ] [ [Back to Top](#top) ]
<hr>

### <a name="load-and-check-module-env"></a>Load and Check Modules and Environment
In this example, we will add the SLURM library, and and verify that it is in your environment
* Check  module environment after loggin on to the system:

```
(base) [username@login01 ~]$ module li

Currently Loaded Modules:
  1) shared   2) slurm/expanse/20.02.3   3) cpu/0.15.4   4) DefaultModules
```

* Note that SLURM (the cluster resource manager) is not in the environment. 
Check environment looking for SLURM commands


```
(base) [username@login01 ~]$ which squeue
/usr/bin/which: no squeue in (/home/username/miniconda3/bin/conda:/home/username/miniconda3/bin:/home/username/miniconda3/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin:/home/username/.local/bin:/home/username/bin)
```

* Since SLURM commands do not exist,  we need to load that module:


```
(base) [username@login01 ~]$ module load slurm
(base) [username@login01 ~]$ which squeue
/cm/shared/apps/slurm/current/bin/squeue
```

* Display loaded module details:


```
(base) [username@login02 ~]$ module display slurm
-------------------------------------------------------------------------------------
   /cm/local/modulefiles/slurm/expanse/20.02.3:
-------------------------------------------------------------------------------------
whatis("Adds Slurm to your environment ")
setenv("CMD_WLM_CLUSTER_NAME","expanse")
setenv("SLURM_CONF","/cm/shared/apps/slurm/var/etc/expanse/slurm.conf")
prepend_path("PATH","/cm/shared/apps/slurm/current/bin")
prepend_path("PATH","/cm/shared/apps/slurm/current/sbin")
prepend_path("MANPATH","/cm/shared/apps/slurm/current/man")
prepend_path("LD_LIBRARY_PATH","/cm/shared/apps/slurm/current/lib64")
prepend_path("LD_LIBRARY_PATH","/cm/shared/apps/slurm/current/lib64/slurm")
prepend_path("LIBRARY_PATH","/cm/shared/apps/slurm/current/lib64")
prepend_path("LIBRARY_PATH","/cm/shared/apps/slurm/current/lib64/slurm")
prepend_path("CPATH","/cm/shared/apps/slurm/current/include")
help([[ Adds Slurm to your environment
]])
```

Once you have loaded the modules, you can check the system variables that are available for you to use.
* To see all variable, run the <b>`env`</b> command. Typically, you will see more than 60 lines containing information such as your login name, shell, your home directory:


```
[username@expanse-ln3 IBRUN]$ env
CONDA_EXE=/home/username/miniconda3/bin/conda
__LMOD_REF_COUNT_PATH=/cm/shared/apps/slurm/current/sbin:1;/cm/shared/apps/slurm/current/bin:1;/home/username/miniconda3/bin/conda:1;/home/username/miniconda3/bin:1;/home/username/miniconda3/condabin:1;/usr/local/bin:1;/usr/bin:1;/usr/local/sbin:1;/usr/sbin:1;/opt/dell/srvadmin/bin:1;/home/username/.local/bin:1;/home/username/bin:1
HOSTNAME=login02
USER=username
HOME=/home/username
CONDA_PYTHON_EXE=/home/username/miniconda3/bin/python
BASH_ENV=/usr/share/lmod/lmod/init/bash
BASHRC_READ=1
LIBRARY_PATH=/cm/shared/apps/slurm/current/lib64/slurm:/cm/shared/apps/slurm/current/lib64
SLURM_CONF=/cm/shared/apps/slurm/var/etc/expanse/slurm.conf
LOADEDMODULES=shared:cpu/1.0:DefaultModules:slurm/expanse/20.02.3
__LMOD_REF_COUNT_MANPATH=/cm/shared/apps/slurm/current/man:1;/usr/share/lmod/lmod/share/man:1;/usr/local/. . . .
MANPATH=/cm/shared/apps/slurm/current/man:/usr/share/lmod/lmod/share/man:/usr/local/share/man:/usr/share/man:/cm/local/apps/environment-modules/current/share/man
MODULEPATH=/cm/shared/apps/spack/cpu/lmod/linux-centos8-x86_64/Core:/cm/local/modulefiles:/etc/modulefiles:/usr/share/modulefiles:/usr/share/Modules/modulefiles:/cm/shared/modulefiles
MODULEPATH_ROOT=/usr/share/modulefiles
PATH=/cm/shared/apps/slurm/current/sbin:/cm/shared/apps/slurm/current/bin:/home/username/miniconda3/bin/conda:/home/username/miniconda3/bin:/home/username/miniconda3/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin:/home/username/.local/bin:/home/username/bin
_LMFILES_=/cm/local/modulefiles/shared:/cm/local/modulefiles/cpu/1.0.lua:/usr/share/modulefiles/DefaultModules.lua:/cm/local/modulefiles/slurm/expanse/20.02.3
MODULESHOME=/usr/share/lmod/lmod
CONDA_DEFAULT_ENV=base
```

To see the value for any of these variables, use the `echo` command. In this example we show how to activate your miniconda environment so you can run Jupyter Notebooks:

```
(base) [username@login02 ~]$ echo $CONDA_PYTHON_EXE
[username@login02 ~]$
[username@login02 ~]$ conda activate
-bash: conda: command not found
[username@login02 ~]$ . /home/$USER/miniconda3/etc/profile.d/conda.sh
[username@login02 ~]$ conda activate
(base) [username@login02 ~]$ which jupyter
~/miniconda3/bin/jupyter
(base) [username@login02 ~]$ echo $CONDA_PYTHON_EXE
/home/username/miniconda3/bin/python
(base) [username@login02 ~]$
```

[ [Back to Modules](#modules) ] [ [Back to Top](#top) ]
<hr>

### Loading Modules at Login <a name="module-login-load"></a>
You can override, and add to the standard set of login modules in two ways.
1. The first is adding module commands to your personal startup files.
2. The second way is through the “module save” command.
*Note: make sure that you always want the module loaded at login*

For Bash:  put the following block into your ```~/.bash_profile``` file:

```
if [ -f ~/.bashrc ]; then
       . ~/.bashrc
fi
```

Place the following in your ```~/.bashrc``` file:

```
# Place  module commands here
# module load hdf5

```

* First edit your ```.bashrc``` and ```.bash_profile``` files:

```
[username@login02 ~]$ cat .bash_profile
# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
[SNIP]
[username@login01 ~]$
[username@login02 ~]$ cat .bashrc
# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi

# Place any module commands here
module load hdf5

[SNIP]
```

* Next LOGOUT and LOG BACK IN:

```
(base) [username@login02 ~]$ env | grep slurm
[snip]
MANPATH=/cm/shared/apps/slurm/current/man:/usr/share/lmod/lmod/share/man:/usr/local/share/man:/usr/share/man:/cm/local/apps/environment-modules/current/share/man
PATH=/cm/shared/apps/slurm/current/sbin:/cm/shared/apps/slurm/current/bin:/home/username/miniconda3/bin/conda:/home/username/miniconda3/bin:/home/username/miniconda3/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin:/home/username/.local/bin:/home/username/bin
[snip]
(base) [username@login02 ~]$ which squeue
/cm/shared/apps/slurm/current/bin/squeue
```
[ [Back to Modules](#modules) ] [ [Back to Top](#top) ]
<hr>

### Troubleshooting:Module Error<a name="module-error"></a>

Sometimes this error is encountered when switching from one shell to another or attempting to run the module command from within a shell script or batch job. The module command may not be inherited between the shells.  To keep this from happening, execute the following command:


```
[expanse-ln3:~]source /etc/profile.d/modules.sh
```
OR add this command to your shell script (including Slurm batch scripts)

[ [Back to Modules](#modules) ] [ [Back to Top](#top) ]
<hr>

## <a name="managing-accounts"></a>Managing Accounts on Expanse
* [Expanse Client Script](#manage-accts-client-script)
* [Using Accounts in Batch Jobs](#manage-accts-batch-script)
* [Managing Users on an Account](#manage-accts-users)

### <a name="manage-accts-client-script"></a>Expanse-Client Script

* The expanse-client script provides additional details regarding User and Project availability and usage located at:

```
/cm/shared/apps/sdsc/current/bin/expanse-client
```

* Example of Script Usage: 

```
[username@login01 ~]$ expanse-client -h
Allows querying the user statistics.

Usage:
  expanse-client [command]

Available Commands:
  help        Help about any command
  project     Get project information
  user        Get user information

Flags:
  -a, --auth      authenticate the request
  -h, --help      help for expanse-client
  -p, --plain     plain no graphics output
  -v, --verbose   verbose output

Use "expanse-client [command] --help" for more information about a command.
```

* Example of using the script shows that the user has allocations on 3 accounts, and SU's remaining:

```
[username@login01 ~]$ expanse-client user -p

 Resource  sdsc_expanse 

 NAME     PROJECT  USED  AVAILABLE  USED BY PROJECT 
----------------------------------------------------
 username  abc123     33      80000              180 
 username  srt456      0       5000               79 
 username  xyz789    318     500000          2905439 
```

* To see who is on an account:

```
[mthomas@login01 dgemm]$  expanse-client project abc123 -v

 Resource          sdsc_expanse    
 Project           xyz789         
 Total allocation  500000         
 Total recorded    289243         
 Total queued      13004           
 Expiration        January 1, 2024 

╭────┬──────────┬───────────────┬─────────────┬───────────┬──────────────────────────┬────────────────────────╮
│    │ NAME     │ USED RECORDED │ USED QUEUED │ AVAILABLE │ USED BY PROJECT RECORDED │ USED BY PROJECT QUEUED │
├────┼──────────┼───────────────┼─────────────┼───────────┼──────────────────────────┼────────────────────────┤
│  1 │ user1    │             0 │           0 │   500000  │                  289243  │                  13004 │
│  2 │ user2    │          6624 │           0 │   500000  │                  289243  │                  13004 │
[SNIP]
│  9 │ user3    │            33 │           0 │   500000  │                  289243  │                  13004 │
│ 10 │ user4    │            14 │           0 │   500000  │                  289243  │                  13004 │
╰────┴──────────┴───────────────┴─────────────┴───────────┴──────────────────────────┴────────────────────────╯

```

### <a name="manage-accts-batch-script"></a>Using Accounts in Batch Jobs
As with the case above, some users will have access to multiple accounts (e.g. an allocation for a research project and a separate allocation for classroom or educational use). Users should verify that the correct project is designated for all batch jobs. Awards are granted for a specific purposes and should not be used for other projects. Designate a project by replacing  << project >> with a project listed as above in the SBATCH directive in your job script:

```
  #SBATCH -A << project >>
```

### <a name="manage-accts-users"></a>Managing Users on an Account
Only project PIs and co-PIs can add or remove users from an account. This can only be done 
via the [XSEDE portal](https://portal.xsede.org) account (there is no command line interface for this). 
After logging in, go to the Add User page for the account.

[ [Back to Managing Accounts](#managing-accounts) ] [ [Back to Top](#top) ]

<hr>
## <a name="job-charging"></a> Job Charging
The charge unit for all SDSC machines, including Expanse, is the Service Unit (SU). This corresponds to:
* Use of one compute core utilizing less than or equal to 2G of data for one hour
* 1 GPU using less than 96G of data for 1 hour. 
Note: your charges are based on the resources that are tied up by your job and don't necessarily reflect how the resources are used. Charges are based on either the number of cores or the fraction of the memory requested, whichever is larger. The minimum charge for any job is 1 SU.

See the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#charging) for more details and factors that affect job charging.


[ [Back to Managing Accounts](#managing-accounts) ] [ [Back to Top](#top) ]

<hr>
## <a name="compilers"></a>Compiling & Linking Code

Expanse provides the Intel, Portland Group (PGI), and GNU compilers along with multiple MPI implementations (MVAPICH2, MPICH2, OpenMPI). Most applications will achieve the best performance on Expanse using the Intel compilers and MVAPICH2 and the majority of libraries installed on Expanse have been built using this combination. Having such a diverse set of compilers avaiable allows for our users to customize the software stack need for thier application. However, there
can be some complexity involed in sorting out the module dependencies needed for your applications. Often the set of modules being loaded depends on the application you are using and the compiler and libraries you may need. In many cases you will need to use the ```module spider``` command to sort out what modules your application will need. Additionally, it is possible the list will change if some of the dependent software changes.

Other compilers and versions can be installed by Expanse staff on request. For more information, see the [Expanse User Guide.]
(https://www.sdsc.edu/support/user_guides/expanse.html#compiling)

<a name="top"> In this Section:
* [Compiling & Linking](#compilers)
    * [Supported Compilers](#compilers-supported")
    * [AMD Optimizing C/C++ Compiler (AOCC)](#compilers-amd)
    * [Intel Compilers](#compilers-intel)
    * [GNU Compilers](#compilers-gnu)
    * [PGI Compilers](#compilers-pgi)

[Back to Top](#top)
<hr>

### <a name="compilers-supported"></a>Supported Compilers
Expanse CPU and GPU nodes have different compiler libraries.

#### CPU Nodes
* GNU, Intel, AOCC (AMD) compilers
* Multiple MPI implementations (OpenMPI, MVAPICH2, and IntelMPI).
* A majority of applications have been built using gcc/10.2.0 which features AMD Rome specific optimization flags (-march=znver2).
* Intel, and AOCC compilers all have flags to support Advanced Vector Extensions 2 (AVX2).

Users should evaluate their application for best compiler and library selection. GNU, Intel, and AOCC compilers all have flags to support Advanced Vector Extensions 2 (AVX2). Using AVX2, up to eight floating point operations can be executed per cycle per core, potentially doubling the performance relative to non-AVX2 processors running at the same clock speed. Note that AVX2 support is not enabled by default and compiler flags must be set as described below.

#### GPU Nodes
Expanse GPU nodes have GNU, Intel, and PGI compilers available along with multiple MPI implementations (OpenMPI, IntelMPI, and MVAPICH2). The gcc/10.2.0, Intel, and PGI compilers have specific flags for the Cascade Lake architecture. Users should evaluate their application for best compiler and library selections.

*Note: that the login nodes are not the same as the GPU nodes, therefore all GPU codes must be compiled by requesting an interactive session on the GPU nodes.*

In this tutorial, we include several hands-on examples that cover many of the cases in the table:
* MPI
* OpenMP
* HYBRID
* GPU
* Local scratch

[ [Back to Running Jobs](#run-jobs) ] [ [Back to Top](#top)
<hr>

### <a name="compilers-amd"></a>AMD Optimizing C/C++ Compiler (AOCC)

The AMD Optimizing C/C++ Compiler (AOCC) is only available on CPU nodes. AMD compilers can be loaded by executing the following commands at the Linux prompt:

```
module load aocc
```

For more information on the AMD compilers run:

```
[flang | clang ] -help
```

Suggested Compilers to used based on programming model and languages:

|Language | Serial | MPI | OpenMP | MPI + OpenMP |
| :---- | :---- | :---- | :---- | :---- |
|Fortran  | flang | mpif90 | ifort -fopenmp | mpif90 -fopenmp |
|C         | clang | mpiclang | icc -fopenmp | mpicc -fopenmp |
| C++     | clang++ | mpiclang | icpc -fopenmp | mpicxx -fopenmp |

### Using the AOCC Compilers

* If you have modified your environment, you can reload by executing the module purge & load commands at the Linux prompt, or placing the load command in your startup file (~/.cshrc or ~/.bashrc)
* Note: The examples below are for the simple “hellompi” examples shown below

In this example, we show how to use the ```swap``` command.
```
[username@login02 ~]$ module list
Currently Loaded Modules:
  1) shared   2) cpu/1.0   3) DefaultModules   4) hdf5/1.10.1   5) intel/ 19.1.1.217
## need to change multiple modules
[username@login02 ~]$ module purge
[username@login02 ~]$ module list
No modules loaded
[username@login02 ~]$ module load slurm
[username@login02 ~]$ module load cpu
[username@login02 ~]$ module load gcc
[username@login02 ~]$ module load openmpi/4.0.4
[username@login02 ~]$ module list
Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) cpu/1.0   3) gcc/10.2.0   4) openmpi/4.0.4
[username@login02 MPI]$ module swap gcc aocc
Due to MODULEPATH changes, the following have been reloaded:
  1) openmpi/4.0.4
[username@login02 ~]$ module list
Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) cpu/1.0   3) aocc/2.2.0   4) openmpi/4.0.4
[username@login02 ~]$ 
```

[ [Back to Running Jobs](#run-jobs) ] [ [Back to Top](#top)
<hr>

### <a name="compilers-intel"></a>Intel Compilers:

The Intel compilers and the MVAPICH2 MPI implementation will be loaded by default. The MKL and related libraries may need several modulrs. If you have modified your environment, you can reload by executing the following commands such as those shown below at the Linux prompt or placing in your startup file (~/.cshrc or ~/.bashrc). Below is the list of modules created for the DGEMM MKL example described below  (on 01/25/21):

```
module purge
module load slurm
module load cpu
module load gpu/0.15.4  
module load intel/19.0.5.281
module load intel-mkl/2020.3.279
```

Recall that the list of modules being loaded depends on the application you are using and the compiler and libraries you may need. In some cases you will need to use the ```module spider``` command to sort out what modules your application will need.  And, it is possible the list will change if some of the dependent software changes.

For AVX2 support, compile with the -xHOST option. Note that -xHOST alone does not enable aggressive optimization, so compilation with -O3 is also suggested. The -fast flag invokes -xHOST, but should be avoided since it also turns on interprocedural optimization (-ipo), which may cause problems in some instances.

Intel MKL libraries are available as part of the "intel" modules on Expanse. Once this module is loaded, the environment variable MKL_ROOT points to the location of the mkl libraries. The MKL link advisor can be used to ascertain the link line (change the MKL_ROOT aspect appropriately).

In the example below, we are working with a serial MKL example that can be found in the examples/MKL/dgemm folder of the GitHub repository.
This example based on an [Intel MKL repo](http://software.intel.com/en-us/articles/intel-sample-source-code-license-agreement/) 
computes the real matrix ```C=alpha*A*B+beta*C``` using Intel(R) MKL

* Repository contents:
```
[username@login01 dgemm]$ ll
total 3758
drwxr-xr-x 2 username abc123       8 Jan 29 00:45 .
drwxr-xr-x 3 username abc123        3 Jan 29 00:25 ..
-rw-r--r-- 1 username abc123     2997 Jan 29 00:25 dgemm_example.f
-rw-r--r-- 1 username abc123      618 Jan 29 00:25 dgemm-slurm.sb
-rw-r--r-- 1 username abc123      363 Jan 29 00:32 README.txt
```

* Source code key lines:
```
 PROGRAM   MAIN

      IMPLICIT NONE

      DOUBLE PRECISION ALPHA, BETA
      INTEGER          M, P, N, I, J
      PARAMETER        (M=2000, P=200, N=1000)
      DOUBLE PRECISION A(M,P), B(P,N), C(M,N)
[SNIP]
      PRINT *, "Computing matrix product using Intel(R) MKL DGEMM "
      CALL DGEMM('N','N',M,N,P,ALPHA,A,M,B,P,BETA,C,M)
[SNIP]
```

* README.txt contents:
```
[username@login01 dgemm]$ cat README.txt 
### MPT:  10/7/2020 -- Example is not working

[1] Compile:

module purge
module load slurm
module load cpu
module load gpu/0.15.4  
module load intel/19.0.5.281
module load intel-mkl/2020.3.279

ifort -o dgemm_example  -mkl -static-intel dgemm_example.f

[2] Run:

sbatch dgemm-slurm.sb

NOTE: for other compilers, replace "gcc"
with the one you want to use.
```

* Contents of the batch script:
```
[username@login01 dgemm]$ cat dgemm-slurm.sb 
#!/bin/bash
#SBATCH --job-name="dgemm_example"
#SBATCH --output="dgemm_example.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --mem=248G
#SBATCH --account=sds173
#SBATCH --export=ALL
#SBATCH -t 00:30:00

#This job runs with 1 nodes, 128 cores per node for a total of 256 cores.
## Environment
module purge
module load cpu/0.15.4
module load gpu/0.15.4 
module load intel/19.0.5.281 
module load intel-mkl/2020.3.279
module load slurm

## Use srun to run the job
srun --mpi=pmi2 -n 128 --cpu-bind=rank dgemm_example
```
An example of the output:
```
Top left corner of matrix A:
          1.           2.           3.           4.           5.           6.
        201.         202.         203.         204.         205.         206.
        401.         402.         403.         404.         405.         406.
        601.         602.         603.         604.         605.         606.
        801.         802.         803.         804.         805.         806.
       1001.        1002.        1003.        1004.        1005.        1006.
 
 Top left corner of matrix B:
         -1.          -2.          -3.          -4.          -5.          -6.
      -1001.       -1002.       -1003.       -1004.       -1005.       -1006.
      -2001.       -2002.       -2003.       -2004.       -2005.       -2006.
      -3001.       -3002.       -3003.       -3004.       -3005.       -3006.
      -4001.       -4002.       -4003.       -4004.       -4005.       -4006.
      -5001.       -5002.       -5003.       -5004.       -5005.       -5006.
 
 Top left corner of matrix C:
 -2.6666E+09  -2.6666E+09  -2.6667E+09  -2.6667E+09  -2.6667E+09  -2.6667E+09
 -6.6467E+09  -6.6467E+09  -6.6468E+09  -6.6468E+09  -6.6469E+09  -6.6470E+09
 -1.0627E+10  -1.0627E+10  -1.0627E+10  -1.0627E+10  -1.0627E+10  -1.0627E+10
 -1.4607E+10  -1.4607E+10  -1.4607E+10  -1.4607E+10  -1.4607E+10  -1.4607E+10
 -1.8587E+10  -1.8587E+10  -1.8587E+10  -1.8587E+10  -1.8588E+10  -1.8588E+10
 -2.2567E+10  -2.2567E+10  -2.2567E+10  -2.2567E+10  -2.2568E+10  -2.2568E+10
 ```


For more information on the Intel compilers run: [ifort | icc | icpc] -help

[Back to Compilers](#compilers)<br>
[Back to Top](#top)
<hr>

### <a name="compilers-gnu"></a>GNU Compilers
The GNU compilers can be loaded by executing the following commands at the Linux prompt or placing in your startup files (~/.cshrc or ~/.bashrc)

```
module purge
module load gnu openmpi_ib
```

For AVX support, compile with -mavx. Note that AVX support is only available in version 4.7 or later, so it is necessary to explicitly load the gnu/4.9.2 module until such time that it becomes the default.

For more information on the GNU compilers: man [gfortran | gcc | g++]

| |Serial | MPI | OpenMP | MPI+OpenMP|
|---|---|---|---|---|
|Fortran | gfortran | mpif90 | gfortran -fopenmp | mpif90 -fopenmp|
|C | gcc | mpicc | gcc -fopenmp | mpicc -fopenmp|
|C++ | g++ | mpicxx | g++ -fopenmp | mpicxx -fopenmp|


[Back to Compilers](#compilers)<br>
[Back to Top](#top)
<hr>

### <a name="compilers-pgi"></a>PGI Compilers
The PGI compilers can be loaded by executing the following commands at the Linux prompt or placing in your startup file (~/.cshrc or ~/.bashrc)

```
module purge
module load pgi mvapich2_ib
```

For AVX support, compile with -fast

For more information on the PGI compilers: man [pgf90 | pgcc | pgCC]

| |Serial | MPI | OpenMP | MPI+OpenMP|
|---|---|---|---|---|
|pgf90 | mpif90 | pgf90 -mp | mpif90 -mp|
|C | pgcc | mpicc | pgcc -mp | mpicc -mp|
|C++ | pgCC | mpicxx | pgCC -mp | mpicxx -mp|

[Back to Compilers](#compilers)<br>
[Back to Top](#top)
<hr>

## Running Jobs on Expanse <a name="run-jobs"></a>
In this Section:
* [Parallel Models](#run-jobs-par-models)
* [Methods for  Running Jobs on Expanse](#run-jobs-methods)
   * [Batch Jobs](#run-jobs-methods-batch)
   * [Interactive Jobs](#run-jobs-methods-ineractive)
   * [Command Line Jobs](#run-jobs-cmdline)
* [SLURM Partitions](#run-jobs-slurm-partition)
   * [SLURM Commands](#run-jobs-slurm-commands)
   * [SLURM Batch Script Example](#run-jobs-slurm-batch)

[Back to Top](#top)
<hr>

### Parallel Models <a name="run-jobs-par-models"></a>
#### Parallel Models: Distributed Memory

<img src="images/distr-memory.png" alt="Distributed Memory architecture" width="300px" />

* Programs that run asynchronously, pass messages for communication and coordination between resources.
* Examples include: SOA-based systems, massively multiplayer online games, peer-to-peer apps.
* Different types of implementations for the message passing mechanism: HTTP, RPC-like connectors, message queues
* HPC historically uses the Message Passing Interface (MPI)

#### Parallel Models: Shared Memory

<img src="images/shared-memory.png" alt="Shared Memory architecture" width="300px" />

* CPUs all share same localized memory (SHMEM)
   * Coordination and communication between tasks via interprocessor communication (IPC) or virtual memory mappings.
* May use: uniform or non-uniform memory access (UMA or NUMA); cache-only memory architecture (COMA).
* Most common HPC API’s for using SHMEM:
   * Portable Operating System Interface (POSIX); Open Multi-Processing (OpenMP) designed for parallel computing – best for multi-core computing.

[ [Back to Running Jobs](#run-jobs) ] [ [Back to Top](#top)
<hr>

### Methods for  Running Jobs on Expanse <a name="run-jobs-methods"></a>

#### Batch Jobs<a name="run-jobs-methods-batch"></a>

* Batch Jobs are used to submit batch scripts to Slurm from the login nodes. You need to specify
   * Partition (queue)
   * Time limit for the run (maximum of 48 hours)
   * Number of nodes, tasks per node; Memory requirements (if any)
   * Job name, output file location; Email info, configuration

* When you run in the batch mode, you submit jobs to be run on the compute nodes using the sbatch command. 
* Remember that computationally intensive jobs should be run only on the compute nodes and not the login nodes.
* Expanse places limits on the number of jobs queued and running on a per group (allocation) and partition basis.
* Please note that submitting a large number of jobs (especially very short ones) can impact the overall  scheduler response for all users.

#### Interactive Jobs<a name="run-jobs-methods-ineractive"></a>
* Interactive Jobs: Use the _srun_ command to obtain nodes for ‘real-time, live’ command line access to a compute node:
__CPU:__
```
srun --partition=debug --qos=debug-normal --pty --account=abc123 --nodes=1 --ntasks-per-node=128 --mem=248 -t 00:30:00 --wait=0 --export=ALL /bin/bash
```

__GPU:__

```
srun   --pty --account=abc123  --nodes=1   --ntasks-per-node=1   --cpus-per-task=10   -p gpu-debug  --gpus=1  -t 00:10:00 /bin/bash
```

[ [Back to Running Jobs](#run-jobs) ] [ [Back to Top](#top)
<hr>

### Command Line Jobs <a name="run-jobs-cmdline"></a>
The login nodes are meant for compilation, file editing, simple data analysis, and other tasks that use minimal compute resources. <em>Do not run parallel or large jobs on the login nodes - even for simple tests</em>. Even if you could run a simple test on the command line on the login node, full tests should not be run on the login node because the performance will be adversely impacted by all the other tasks and login activities of the other users who are logged onto the same node. For example, at the moment that this note was written,  a `gzip` process was consuming 98% of the CPU time:
    ```
    [username@comet-ln3 OPENMP]$ top
    ...
      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                      
    19937 XXXXX     20   0  4304  680  300 R 98.2  0.0   0:19.45 gzip
    ```

Commands that you type into the terminal and run on the sytem are considered *jobs* and they consume resources.  <em>Computationally intensive jobs should be run only on the compute nodes and not the login nodes</em>.

[Back to Running Jobs](#run-jobs)<br>
[Back to Top](#top)
<hr>

 ### SLURM Resource Manager <a name="run-jobs-slurm"></a>
* Expanse uses the _Simple Linux Utility for Resource Management (SLURM)_ resource manager. Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters  [https://slurm.schedmd.com/documentation.html](https://slurm.schedmd.com/documentation.html).

| logging on to Expanse | SLURM Architecture |
| :--- | :--- |
| <img src="images/login-nodes-cluster-nodes.png" alt="Login nodes to cluster diagram" width="300px" /> | <img src="images/slurm-sched-arch.png" alt="Slurm Scheduler Architecture" width="300px" /> |
| User logs onto Expanse, and submits a batch script to the SLURM Controller daemon | SLURM parses the batch script for correct syntax and then queues up the job until the requested resources are available |

* SLURM is the "Glue" for parallel computer to schedule and execute jobs
  * Role: Allocate resources within a cluster
  * Nodes (unique IP address)
  * Interconnect/switches
  * Generic resources (e.g. GPUs)
  * Launch and otherwise manage jobs


[Back to Running Jobs](#run-jobs)<br>
[Back to Top](#top)
<hr>

 ### SLURM Partitions <a name="run-jobs-slurm-partition"></a>
About Partitions

|	Partition Name	|	Max Walltime	|	Max Nodes/ Job	|	Max Running Jobs	|	Max Running + Queued Jobs	|	Charge Factor	|	Comments	|
|	:----	|	:----:	|	:----:	|	:----:	|	:----:	|	:----:	|	:----	|
|	compute	|	48 hrs	|	32	|	64	|	128	|	1	|	Used for exclusive access to regular compute nodes	|
|	shared	|	48 hrs	|	1	|	4096	|	4096	|	1	|	Single-node jobs using fewer than 128 cores	|
|	gpu	|	48 hrs	|	4	|	4	|	8 (32 Tres GPU)	|	1	|	Used for exclusive access to the GPU nodes	|
|	gpu-shared	|	48 hrs	|	1	|	16	|	24 (24 Tres GPU)	|	1	|	Single-node job using fewer than 4 GPUs	|
|	large-shared	|	48 hrs	|	1	|	1	|	4	|	1	|	Single-node jobs using large memory up to 2 TB (minimum memory required 256G)	|
|	debug	|	15 min	|	2	|	1	|	2	|	1	|	Priority access to compute nodes set aside for testing of jobs with short walltime and limited resources	|
|	gpu-debug	|	15 min	|	2	|	1	|	2	|	1	|	** Priority access to gpu nodes set aside for testing of jobs with short walltime and limited resources	|
|	preempt	|	7 days	|	32	|		|	128	|	0.8	|	Discounted jobs to run on free nodes that can be pre-empted by jobs submited to any other queue (NO REFUNDS)	|
|	gpu-preempt	|	7 days	|	1	|		|	24 (24 Tres GPU)	|	0.8	|	Discounted jobs to run on unallocated nodes that can be pre-empted by jobs submitted to higher priority queues (NO REFUNDS	|

[Back to Running Jobs](#run-jobs)<br>
[Back to Top](#top)
<hr>

### Common SLURM Commands <a name="run-jobs-slurm-commands"></a>
Here are a few key Slurm commands. For more information, run the `man slurm` or see this page:

* Submit jobs using the sbatch command:

```
$ sbatch mycode-slurm.sb 
```

* Submitted batch job 8718049
Check job status using the squeue command:

```
$ squeue -u $USER
             JOBID PARTITION     NAME     USER      ST       TIME  NODES  NODELIST(REASON)
           8718049   compute       mycode user   PD       0:00       1               (Priority)
```

* Once the job is running:
```
$ squeue -u $USER
             JOBID PARTITION     NAME     USER    ST       TIME  NODES  NODELIST(REASON)
           8718049     debug        mycode user   R         0:02      1           expanse-14-01
```

* Cancel a running job:

```
$ scancel 8718049
```

[Back to Running Jobs](#run-jobs)<br>
[Back to Top](#top)
<hr>

### SLURM Batch Script Example <a name="run-jobs-slurm-batch"></a>
Below is an example of a batch script that prints our your environment on the compute node:

```
[username@login01 ENV_INFO]$ cat env-slurm.sb 
#!/bin/bash
#SBATCH --job-name="envinfo"
#SBATCH --output="envinfo.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --export=ALL
#SBATCH -t 00:01:00

## Environment
module purge
module load slurm
module load cpu
##  perform some basic unix commands
echo "----------------------------------"
echo "hostname= " `hostname` 
echo "date= " `date` 
echo "whoami= " `whoami` 
echo "pwd= " `pwd` 
echo "module list= " `module list` 
echo "----------------------------------"
echo "env= " `env` 
echo "----------------------------------"
```

* Portion of the output generated by this script:

```
[username@login01 ENV_INFO]$ cat envinfo.108867.exp-6-56.out 
----------------------------------
hostname=  exp-6-56
date=  Wed Oct 7 23:45:43 PDT 2020
whoami=  username
pwd=  /home/username/DEMO/ENV_INFO
Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) cpu/1.0
----------------------------------
env=  SLURM_MEM_PER_CPU=1024 LD_LIBRARY_PATH=/cm/shared/apps/slurm/current/lib64/slurm:/cm/shared/apps/slurm/current/lib64 LS_COLORS=rs=0

[SNIP]

 MODULESHOME=/usr/share/lmod/lmod LMOD_SETTARG_FULL_SUPPORT=no HISTSIZE=5000 LMOD_PKG=/usr/share/lmod/lmod LMOD_CMD=/usr/share/lmod/lmod/libexec/lmod SLURM_LOCALID=0 LESSOPEN=||/usr/bin/lesspipe.sh %s LMOD_FULL_SETTARG_SUPPORT=no LMOD_DIR=/usr/share/lmod/lmod/libexec BASH_FUNC_module%%=() { eval $($LMOD_CMD bash "$@") && eval $(${LMOD_SETTARG_CMD:-:} -s sh) } BASH_FUNC_ml%%=() { eval $($LMOD_DIR/ml_cmd "$@") } _=/usr/bin/env
----------------------------------
```

[ [Back to Running Jobs](#run-jobs) ] [ [Back to Top](#top)
<hr>

## Compiling and Running CPU Jobs<a name="comp-and-run-cpu-jobs"></a>

**Sections:**
   * [Hello World (MPI)](#hello-world-mpi)
   * [Hello World (OpenMP)](#hello-world-omp)
   * [Hello World Hybrid (MPI + OpenMP)](#hybrid-mpi-omp)

[ [Back to Top](#top) ]
<hr>

### General Steps: Compiling/Running Jobs

* Change to a working directory (for example the expanse101 directory):

```
cd /home/$USER/expanse101/MPI
```

* Verify that the correct modules loaded:

```
module list
Currently Loaded Modulefiles:
  1) slurm/expanse/20.02.3   2) cpu/1.0   3) gcc/10.2.0   4) openmpi/4.0.4
```

* Compile the MPI hello world code:

```
mpif90 -o hello_mpi hello_mpi.f90
```

Verify executable has been created (check that date):

```
ls -lt hello_mpi
-rwxr-xr-x 1 user sdsc 721912 Mar 25 14:53 hello_mpi
```

* Submit job

```
sbatch hello_mpi_slurm.sb
```

[ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>


## Hello World (MPI) <a name="hello-world-mpi"></a>

**Subsections:**
* [Hello World (MPI): Source Code](#hello-world-mpi-source)
* [Hello World (MPI): Compiling](#hello-world-mpi-compile)
* [Hello World (MPI): Batch Script Submission](#hello-world-mpi-batch-submit)
* [Hello World (MPI): Batch Script Output](#hello-world-mpi-batch-output)
* [Hello World (MPI): Interactive Jobs](#hello-world-mpi-interactive)

[ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (MPI): Source Code <a name="hello-world-mpi-source"></a>
* Change to the tutorial `MPI` examples directory:
* Source code with basic MPI elements:

```
[username@login01 MPI]$ cat hello_mpi.f90 
!  Fortran example  
   program hello
   include 'mpif.h'
   integer rank, size, ierror, tag, status(MPI_STATUS_SIZE)
   
   call MPI_INIT(ierror)
   call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
   call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
   print*, 'node', rank, ': Hello world!'
   call MPI_FINALIZE(ierror)
   end
[username@login01 MPI]$ 
```

[ [Back to Hello World MPI](#hello-world-mpi) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ]
 [ [Back to Top](#top) ]
<hr>

### Hello World (MPI): Compiling <a name="hello-world-mpi-compile"></a>
* To compile, checkout the instructions in the README.txt file.
* Follow the instructions in the batch script provided for the compiler you want to test.

```
[username@login01 MPI]$ cat README.txt 
[1] Compile:
# Load module environment
module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi/4.0.4
mpif90 -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:
sbatch hellompi-slurm.sb

[2b] Run using Interactive CPU Node
srun --partition=debug  --pty --account=abc123 --nodes=1 --ntasks-per-node=128 --mem=248G -t 00:30:00 --wait=0 --export=ALL /bin/bash
```

* Follow the compile instructions for the compiler that you want to use

```
[username@login01 MPI]$ module purge
[username@login01 MPI]$ module load slurm
[username@login01 MPI]$ module load cpu
[username@login01 MPI]$ module load gcc/10.2.0
[username@login01 MPI]$ module load openmpi/4.0.4
[username@login01 MPI]$ module load openmpi/4.0.4
[username@login01 MPI]$ module list

Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) cpu/1.0   3) gcc/10.2.0   4) openmpi/4.0.4
```

* Next, compile the code:


```
[username@login01 MPI]$mpif90 -o hello_mpi hello_mpi.f90
[username@login01 MPI]$ mpif90 -o hello_mpi hello_mpi.f90
[username@login01 MPI]$ ll
total 125
drwxr-xr-x 2 username abc123    12 Dec 10 00:58 .
drwxr-xr-x 8 username abc123     8 Oct  8 04:16 ..
-rwxr-xr-x 1 username abc123 21576 Oct  7 11:28 hello_mpi
[snip]
```


[ [Back to Hello World MPI](#hello-world-mpi) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (MPI): Batch Script Submission <a name="hello-world-mpi-batch-submit"></a>
* There are several batch scripts provided that contain the module commands needed to compile
and run the code. The contents of the default batch script are:

```
[username@login01 MPI]$ cat hellompi-slurm.sb
#!/bin/bash
#SBATCH --job-name="hellompi"
#SBATCH --output="hellompi.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=128
#SBATCH --export=ALL
#SBATCH -t 00:10:00

#This job runs with 2 nodes, 128 cores per node for a total of 256 cores.
## Environment
module purge
module load slurm
module load cpu
module load gcc/10.2.0
module load openmpi/4.0.4

## Use srun to run the job

srun --mpi=pmi2 -n 256 --cpu-bind=rank ./hello_mpi
```

* In this batch script we are using the GNU compiler, and asking for 2 CPU compute nodes, with 128 tasks per node for a total of 256 tasks.
* the name of job is set in line 2, while the name of the output file is set in line 3, where "%j" is the SLURM JOB_ID, and and "%N" is the compute node name. You can name your outupt file however you wish, but it helpful to keep track of the JOB_ID and node info in case something goes wrong.

* Submit the batch script Submission using the sbatch commmand and monitor the job status using the squeue command:

```
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  username PD       0:00      2 (Priority)
[username@login01 MPI]$ squeue -u username -u username
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  username PD       0:00      2 (Priority)
[username@login01 MPI]$ squeue -u username -u username
^[[A             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  username CF       0:01      2 exp-2-[28-29]
[username@login01 MPI]$ squeue -u username -u username
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  username  R       0:02      2 exp-2-[28-29]
[username@login01 MPI]$ squeue -u username -u username
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
[username@login01 MPI]$ ll
total 151
drwxr-xr-x 2 username abc123    13 Dec 10 01:06 .
drwxr-xr-x 8 username abc123     8 Oct  8 04:16 ..
-rwxr-xr-x 1 username abc123 21576 Oct  8 03:12 hello_mpi
-rw-r--r-- 1 username abc123  8448 Oct  8 03:32 hellompi.667424.exp-2-28.out
[username@login01 MPI]$
[username@login01 MPI]$
[username@login01 MPI]$ cat hellompi.667424.exp-2-28.out
 node           1 : Hello world!
 node           0 : Hello world!
 [snip]
 node         247 : Hello world!
 node         254 : Hello world!
 node         188 : Hello world!
 node         246 : Hello world!
```

[ [Back to Hello World MPI](#hello-world-mpi) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (MPI): Batch Script Output <a name="hello-world-mpi-batch-output"></a>
Batch Script Output

[ [Back to Hello World MPI](#hello-world-mpi) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (MPI): Interactive Jobs <a name="hello-world-mpi-interactive"></a>
Interactive Jobs

[ [Back to Hello World MPI](#hello-world-mpi) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

## Hello World (OpenMP) <a name="hello-world-omp"></a>
**Subsections:**
* [Hello World (OpenMP): Source Code](#hello-world-omp-source)
* [Hello World (OpenMP): Compiling](#hello-world-omp-compile)
* [Hello World (OpenMP): Batch Script Submission](#hello-world-omp-batch-submit)
* [Hello World (OpenMP): Batch Script Output](#hello-world-omp-batch-output)

[ [Back to Hello World OpenMP](#hello-world-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (OpenMP): Source Code <a name="hello-world-omp-source"></a>
Source Code.

```
hello-world-omp  source code
```
[ [Back to Hello World OpenMP](#hello-world-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ]
 [ [Back to Top](#top) ]
<hr>

### Hello World (OpenMP): Compiling <a name="hello-world-omp-compile"></a>
Compiling.

[ [Back to Hello World OpenMP](#hello-world-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (OpenMP): Batch Script Submission <a name="hello-world-omp-batch-submit"></a>
Batch Script Submission

[ [Back to Hello World OpenMP](#hello-world-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (OpenMP): Batch Script Output <a name="hello-world-omp-batch-output"></a>
Batch Script Output

[ [Back to Hello World OpenMP](#hello-world-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>


## Compiling and Running Hybrid (MPI + OpenMP) Jobs <a name="hybrid-mpi-omp"></a>
**Subsections:**
* [Hybrid (MPI + OpenMP): Source Code](#hybrid-mpi-omp-source)
* [Hybrid (MPI + OpenMP): Compiling](#hybrid-mpi-omp-compile)
* [Hybrid (MPI + OpenMP): Batch Script Submission](#hybrid-mpi-omp-batch-submit)
* [Hybrid (MPI + OpenMP): Batch Script Output](#hybrid-mpi-omp-batch-output)

[[Back to Hybrid (MPI+OpenMP)](#hybrid-mpi-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World Hybrid (MPI + OpenMP): Source Code <a name="hybrid-mpi-omp-source"></a>
Source Code.

```
aaaaa
```
[[Back to Hybrid (MPI+OpenMP)](#hybrid-mpi-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World Hybrid (MPI + OpenMP): Compiling <a name="hybrid-mpi-omp-compile"></a>
Compiling.

[[Back to Hybrid (MPI+OpenMP)](#hybrid-mpi-omp) ]  [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World Hybrid (MPI + OpenMP): Batch Script Submission <a name="hybrid-mpi-omp-batch-submit"></a>
Batch Script Submission

[ [Back to Hybrid (MPI+OpenMP)](#hybrid-mpi-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World Hybrid (MPI + OpenMP): Batch Script Output <a name="hybrid-mpi-omp-batch-output"></a>

Batch Script Output

[[Back to Hybrid (MPI+OpenMP)](#hybrid-mpi-omp) ] [ [Back to Compile and Run CPU](#comp-run-cpu) ] [ [Back to Top](#top) ]
<hr>

## Compiling and Running GPU Jobs <a name="comp-run-gpu"></a>
**Sections**
* [Using Expanse GPU Nodes](#comp-run-gpu-nodes)
* [Using Interactive GPU Nodes](#comp-run-gpu-interactive)
* [Hello World (GPU): Source Code](#hello-world-gpu)

### Using Expanse GPU Nodes <a name="comp-run-gpu-nodes"></a>
Using Expanse GPU Nodes

#### Expanse GPU Hardware

|	GPU Type	|	NVIDIA V100 SMX2	|
|	  :----	|	  :----
|	Nodes	|	52	|
|	GPUs/node	|	4	|
|	CPU Type	|	Xeon Gold 6248	|
|	Cores/socket	|	20	|
|	Sockets	|	2	|
|	Clock speed	|	2.5 GHz	|
|	Flop speed	|	34.4 TFlop/s	|
|	Memory capacity	|	*384 GB DDR4 DRAM	|
|	Local Storage	|	1.6TB Samsung PM1745b NVMe PCIe SSD	|
|	Max CPU Memory bandwidth	|	281.6 GB/s	|

#### Using GPU Nodes

* GPU nodes are allocated as a separate resource. The conversion rate is (TBD) Expanse Service Units (SUs) to 1 V100 GPU-hour. 
* Login nodes are not the same as the GPU nodes:
   *  _GPU codes must be compiled by requesting an interactive session on a GPU nodes_
* Batch: GPU nodes can be accessed via either the "gpu" or the "gpu-shared" partitions.
   *  #SBATCH -p gpu
   * or #SBATCH -p gpu-shared
* Be sure to setup  your CUDA environment:

```
#Environment
module purge
module load slurm
module load gpu
module load pgi
```

* Interactive GPU node:

```
srun   --pty   --nodes=1 --account=abc123  --ntasks-per-node=1   --cpus-per-task=10   -p gpu-debug  --gpus=1  -t 00:10:00 /bin/bash
```

[ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

### Using Interactive GPU Nodes  <a name="comp-run-gpu-interactive"></a>

* Change to the tutorial `OpenACC` directory

```
[username@exp-7-59 OpenACC]$ ll
total 71
-rw-r--r-- 1 username abc123  2136 Oct  7 11:28 laplace2d.c
-rwxr-xr-x 1 username abc123 52056 Oct  7 11:28 laplace2d.openacc.exe
-rw-r--r-- 1 username abc123   234 Oct  7 11:28 OpenACC.108739.exp-7-57.out
-rw-r--r-- 1 username abc123   307 Oct  8 00:21 openacc-gpu-shared.sb
-rw-r--r-- 1 username abc123  1634 Oct  7 11:28 README.txt
-rw-r--r-- 1 username abc123  1572 Oct  7 11:28 timer.h
```

* Obtain an interactive node:

```
[username@login01 OpenACC]$ srun   --pty   --nodes=1   --ntasks-per-node=1   --cpus-per-task=10   -p gpu-debug  --gpus=1  -t 00:10:00 /bin/bash
```

[ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

#### Obtaining GPU/CUDA: Node Information

* Once you are on an interactive node, you can check node configuration using the nvidia-smi command:

```
[username@exp-7-59 OpenACC]$ nvidia-smi
Thu Oct  8 03:58:44 2020       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.51.05    Driver Version: 450.51.05    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:18:00.0 Off |                    0 |
| N/A   32C    P0    41W / 300W |      0MiB / 32510MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
[username@exp-7-59 OpenACC]$ 
```
[ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

#### GPU: Must Compile on Interactive node

```
[username@login01 OpenACC]$
cat README.txt 
[1] Compile Code:
(a) Get an interactive GPU debug node:
module load slurm
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-debug --gpus=1 -t 00:10:00 /bin/bash

(b) On the GPU node:
module purge
module load slurm
module load gpu
module load pgi
pgcc -o laplace2d.openacc.exe -fast -Minfo -acc -ta=tesla:cc70 laplace2d.c

Compiler output:
GetTimer:
     20, include "timer.h"
          61, FMA (fused multiply-add) instruction(s) generated
laplace:
     47, Loop not fused: function call before adjacent loop
         Loop unrolled 8 times
         FMA (fused multiply-add) instruction(s) generated
     55, StartTimer inlined, size=2 (inline) file laplace2d.c (37)

[SNIP]
          75, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
         77, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */
     88, GetTimer inlined, size=9 (inline) file laplace2d.c (54)
Exit out of debug node after this)

[2] Run job:
sbatch openacc-gpu-shared.sb 
```

[ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

### [Hello World (GPU)](#hello-world-gpu)
**Subsections:**
* [Hello World (GPU): Source Code](#hello-world-gpu-source)
* [Hello World (GPU): Compiling](#hello-world-gpu-compile)
* [Hello World (GPU): Batch Script Submission](#hello-world-gpu-batch-submit)
* [Hello World (GPU): Batch Script Output](#hello-world-gpu-batch-output)

### Hello World (GPU): Source Code  <a name="hello-world-gpu-source"></a>
Source Code

```
[username@login01 OpenACC]$ !cat
cat laplace2d.c
/*
 *  Copyright 2012 NVIDIA Corporation
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#include <math.h>
#include <string.h>
#include <stdio.h>
#include "timer.h"

#define NN 4096
#define NM 4096

double A[NN][NM];
double Anew[NN][NM];

int main(void)
{
	int laplace(void);
	printf("main()\n");
	laplace();
}

int laplace()
{
    const int n = NN;
    const int m = NM;
    const int iter_max = 1000;

    const double tol = 1.0e-6;
    double error     = 1.0;

    memset(A, 0, n * m * sizeof(double));
    memset(Anew, 0, n * m * sizeof(double));

    for (int j = 0; j < n; j++)
    {
        A[j][0]    = 1.0;
        Anew[j][0] = 1.0;
    }
    printf("Jacobi relaxation Calculation: %d x %d mesh\n", n, m);
    StartTimer();
    int iter = 0;

#pragma acc data copy(A), create(Anew)
    while ( error > tol && iter < iter_max )
    {
        error = 0.0;

#pragma acc kernels
        for( int j = 1; j < n-1; j++)
        {
            for( int i = 1; i < m-1; i++ )
            {
                Anew[j][i] = 0.25 * ( A[j][i+1] + A[j][i-1]
                                    + A[j-1][i] + A[j+1][i]);
                error = fmax( error, fabs(Anew[j][i] - A[j][i]));
            }
        }

#pragma acc kernels
        for( int j = 1; j < n-1; j++)
        {
            for( int i = 1; i < m-1; i++ )
            {
                A[j][i] = Anew[j][i];    
            }
        }

        if(iter % 100 == 0) printf("%5d, %0.6f\n", iter, error);

        iter++;
    }
    double runtime = GetTimer();
    printf(" total: %f s\n", runtime / 1000);
}
```

[ [Back to Hello World (GPU)](#hello-world-gpu)] [ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (GPU): Compiling  <a name="hello-world-gpu-compile"></a>
Compile the code:
1. obtain an interactive node
2. load the right Modules
3. compile the Source code
4. exit interactive node


```
[username@login01 ~]$ module load slurm
[username@login01 ~]$ srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-debug -A abc123 --gpus=1 -t 00:10:00 /bin/bash
srun: job 667263 queued and waiting for resources
srun: job 667263 has been allocated resources
[username@exp-7-59 ~]$ module purge
[username@exp-7-59 ~]$ module load slurm
[username@exp-7-59 ~]$ module load gpu
[username@exp-7-59 ~]$ module load pgi
[username@exp-7-59 ~]$ module list

Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) gpu/1.0   3) pgi/20.4

  [username@exp-7-59 OpenACC]$ pgcc -o laplace2d.openacc.exe -fast -Minfo -acc -ta=tesla:cc70 laplace2d.c
  "laplace2d.c", line 91: warning: missing return statement at end of non-void
            function "laplace"
    }
    ^

  GetTimer:
       20, include "timer.h"
            61, FMA (fused multiply-add) instruction(s) generated
[SNIP]
[username@exp-7-59 OpenACC]$ exit
exit
[username@login01 ~]$
```

[ [Back to Hello World (GPU)](#hello-world-gpu) ] [ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (GPU): Batch Script Submission  <a name="hello-world-gpu-batch-submit"></a>
* Batch Script Contents

```
[username@login01 OpenACC]$ cat openacc-gpu-shared.sb 
#!/bin/bash
#SBATCH --job-name="OpenACC"
#SBATCH --output="OpenACC.%j.%N.out"
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH -t 01:00:00

#Environment
module purge
module load slurm
module load gpu
module load pgi

#Run the job
./laplace2d.openacc.exe
```
* Submit the batch script, and monitor queue status:
   * PD == Pending
   * ST == Starting
   *  R == Running

```
[username@login01 OpenACC]$ !sb
sbatch openacc-gpu-shared.sb
Submitted batch job 667276
[username@login01 OpenACC]$ !sq
squeue -u username -u username
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            667276 gpu-share  OpenACC  username PD       0:00      1 (Priority)
[username@login01 OpenACC]$
[username@login01 OpenACC]$ squeue -u username -u username
             JOBID PARTITION     NAME     USER R       TIME  NODES NODELIST(REASON)
             [username@login01 OpenACC]$ cat OpenACC.667276.exp-1-60.out
             main()
             Jacobi relaxation Calculation: 4096 x 4096 mesh
                 0, 0.250000
               100, 0.002397
               200, 0.001204
               300, 0.000804
               400, 0.000603
               500, 0.000483
               600, 0.000403
               700, 0.000345
               800, 0.000302
               900, 0.000269
              total: 1.044246 s
             [username@login01 OpenACC]$

```


[ [Back to Hello World (GPU)](#hello-world-gpu) ] [ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>

### Hello World (GPU): Batch Script Output  <a name="hello-world-gpu-batch-output"></a>

* Batch Script Output:

```
dddd

```

[ [Back to Hello World (GPU)](#hello-world-gpu) ] [ [Back to Compile and Run GPU Jobs](#comp-run-gpu) ] [ [Back to Top](#top) ]
<hr>
