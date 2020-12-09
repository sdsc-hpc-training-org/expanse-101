

# Expanse 101:  Introduction to Running Jobs on the Expanse Supercomputer <V2>
Presented by Mary Thomas (SDSC,  <mpthomas@ucsd.edu> )
<hr>
In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: https://github.com/sdsc-hpc-training-org/basic_skills.

# Misc Notes/Updates:
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
* [Expanse Overview & Innovative Features](#overview)
* [Getting Started](#getting-started)
  * [Expanse Accounts](#expanse-accounts)
  * [Logging Onto Expanse](#expanse-logon)
  * [Obtaining Example Code](#example-code)
  * [Expanse User Portal](#user-portal)
* [Modules](#modules)
   * [Loading Modules During Login](module-login-load)
   * [Modules: Popular Lmod Commands](module-commands)

* [Account Management](#accounts)
* Compiling and Linking Code
* Running Jobs
* Hands-on Examples
* MPI Jobs
* OpenMP Jobs
* GPU/CUDA Jobs
* Hybrid MPI-OpenMP Jobs
* Data and Storage, Globus Endpoints, Data Movers, Mount Points
* Final Comments

<hr>



<img src="images/expanse_overview.png" alt="Expanse Overview" width="500px">

## Expanse Overview: <a name="overview"></a>

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

### New Expanse Feature: Composable Systems

<img src="images/expanse_composable_systems.png" alt="Expanse Composable Systems" width="400px" />
Composable Systems will support complex, distributed, workflows – making Expanse part of a larger CI ecosystem.

* Bright Cluster Manager + Kubernetes
* Core components developed via NSF- funded CHASE-CI (NSF Award # 1730158), and the Pacific Research Platform (NSF Award # 1541349)
* Requests for a composable system will be part of an XRAC request
* Advanced User Support resources available to assist with projects - this is part of our operations funding.
  *  Webinar scheduled for April 2021. See: https://www.sdsc.edu/education_and_training/training_hpc.html


### New Expanse Feature: Cloud Bursting
Expanse will support integration with public clouds:

  <img src="images/expanse_cloud_burst_aws.png" alt="Expanse Cloud Bursting to AWS" width="400px" />

* Supports projects that share data, need access to novel technologies, and integrate cloud resources into workflows
* Slurm + in-house developed software + Terraform (Hashicorp)
* Early work funded internally and via NSF E-CAS/Internet2 project for CIPRES (Exploring Cloud for the Acceleration of Science, Award #1904444).
* Approach is cloud-agnostic and will support the major cloud providers.
* Users submit directly via Slurm, or as part of a composed system.
* Options for data movement: data in the cloud; remote mounting of file systems; cached filesystems (e.g., StashCache), and data transfer during the job.
* Funding for users cloud resources is not part of an Expanse award: the researcher must have access to cloud computing credits via other NSF awards and funding.

<br>
[Back to Top](#top)
<hr>



## <a name="getting-started"></a>Getting Started on Expanse
In this Section:
* [Expanse Accounts](#expanse-accounts)
* [Logging Onto Expanse](#expanse-logon)
* [Obtaining Example Code](#example-code)
* [Expanse User Portal](#user-portal) 

<br>
[Back to Top](#top)
<hr>

### Expanse Accounts<a name="expanse-accounts"></a>
You must have a expanse account in order to access the system.
* Obtain a trial account here:  http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts
* You can use your XSEDE account.


### Logging Onto Expanse<a name="expanse-logon"></a>

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
[username@login02 ~]$
[username@login02 ~]$ pwd
/home/username
[username@login02 ~]$
[username@login02 ~]$
```
[Back to Getting Started](#getting-started) <br>
[Back to Top](#top)
<hr>

### Obtaining Tutorial Example Code<a name="example-code"></a>
We will be clone the example code from GitHub repository located here:
https://github.com/sdsc-hpc-training-org/expanse-101

The example below will be for anonymous HTTPS downloads

* Create a test directory hold the expanse example files:
*
```
localhost:hpctrain username$ git clone https://github.com/sdsc-hpc-training-org/expanse-101.git
Cloning into 'expanse-101'...
remote: Enumerating objects: 79, done.
remote: Counting objects: 100% (79/79), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 302 (delta 36), reused 39 (delta 15), pack-reused 223
Receiving objects: 100% (302/302), 3.70 MiB | 4.66 MiB/s, done.
Resolving deltas: 100% (130/130), done.
localhost:hpctrain username$ ll
total 0
drwxr-xr-x   3 username  staff   96 Nov 18 08:12 .
drwxr-xr-x  11 username  staff  352 Nov 18 08:11 ..
drwxr-xr-x  10 username  staff  320 Nov 18 08:12 expanse-101
localhost:hpctrain username$ cd expanse-101/
localhost:expanse-101 username$ ls -al
total 48
drwxr-xr-x  10 username  staff   320 Nov 18 08:12 .
drwxr-xr-x   3 username  staff    96 Nov 18 08:12 ..
-rw-r--r--   1 username  staff  6148 Nov 18 08:12 .DS_Store
drwxr-xr-x  12 username  staff   384 Nov 18 08:12 .git
-rw-r--r--   1 username  staff   459 Nov 18 08:12 .gitignore
-rw-r--r--   1 username  staff  1005 Nov 18 08:12 README.md
drwxr-xr-x   4 username  staff   128 Nov 18 08:12 docs
drwxr-xr-x   7 username  staff   224 Nov 18 08:12 examples
drwxr-xr-x  12 username  staff   384 Nov 18 08:12 images
-rw-r--r--   1 username  staff  5061 Nov 18 08:12 running_jobs_on_expanse.md
```

*Note*: you can learn to create and modify directories as part of the *Getting Started* and *Basic Skills* preparation found here:
https://github.com/sdsc-hpc-training-org/basic_skills

The examples directory contains the code we will cover in this tutorial:

```
[username@login01 examples]$ ls -al examples
total 88
drwxr-xr-x 6 username use300 6 Oct  7 14:15 .
drwxr-xr-x 5 username use300 8 Oct  7 14:15 ..
drwxr-xr-x 2 username use300 6 Oct  7 14:15 HYBRID
drwxr-xr-x 2 username use300 6 Oct  7 14:15 MPI
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OpenACC
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OPENMP
[username@login01 examples]$ ls -al examples/MPI
total 63
drwxr-xr-x 2 username use300     6 Oct  7 14:15 .
drwxr-xr-x 6 username use300     6 Oct  7 14:15 ..
-rwxr-xr-x 1 username use300 21576 Oct  7 14:15 hello_mpi
-rw-r--r-- 1 username use300   329 Oct  7 14:15 hello_mpi.f90
-rw-r--r-- 1 username use300   464 Oct  7 14:15 hellompi-slurm.sb
-rw-r--r-- 1 username use300   181 Oct  7 14:15 README.txt

```
All examples will contain source code, along with a batch script example so you can compile and run all examples on Expanse.
<br>
[Back to Getting Started](#getting-started) <br>
[Back to Top](#top)


### Expanse User Portal<a name="user-portal"></a>
<img src="images/expanse_user_portal.png" alt="Expanse User Portal" width="400px" />

* See: https://portal.expanse.sdsc.edu
* Quick and easy way for Expanse users to login, transfer and edit files and submit and monitor jobs.
* Gateway for launching interactive applications such as MATLAB, Rstudio
* Integrated web-based environment for file management and job submission.
* All Users with valid Expanse Allocation and XSEDE Based credentials have access via their XSEDE credentials..


[Back to Getting Started](#getting-started) <br>
[Back to Top](#top)
<hr>


## <a name="modules"></a>Expanse Environment Modules: Customizing Your User Environment
The Environment Modules package provides for dynamic modification of your shell environment. Module commands set, change, or delete environment variables, typically in support of a particular application. They also let the user choose between different versions of the same software or different combinations of related codes. See the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#modules).

In this Section:
* [Introduction to the Lua Lmod Module System](#module-lmod-intro)
* [Common module commands](#module-commands)
* [Modules: Popular Lmod Commands](module-commands)

<!----
* [Load and Check Modules and Environment](#load-and-check-module-env)
* [Module Error: command not found](#module-error)
---->

[Back to Modules](#modules) <br>
[Back to Top](#top)
<br>

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

[Back to Modules](#modules) <br>
[Back to Top](#top)
<br>

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

* Default environment: `list`, `li`

```
(base) [username@login01 expanse-101]$ module list
Currently Loaded Modules:
  1) shared   2) cpu/1.0   3) DefaultModules
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
    You will need to load all module(s) on any one of the lines below before the "intel-mpi/2019.8.254" module is available to load.

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

[Back to Modules](#modules) <br>
[Back to Top](#top)<br>


### <a name="load-and-check-module-env"></a>Load and Check Modules and Environment
In this example, we will add the SLURM library, and and verify that it is in your environment
* Check login module environment


```
(base) [username@login01 ~]$ module li

Currently Loaded Modules:
  1) shared   2) cpu/1.0   3) DefaultModules
```

* Note that SLURM is not in the environment. Check environment looking for SLURM commands


```
(base) [username@login01 ~]$ which squeue
/usr/bin/which: no squeue in (/home/username/miniconda3/bin/conda:/home/username/miniconda3/bin:/home/username/miniconda3/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin:/home/username/.local/bin:/home/username/bin)
```

* SLURM commands do not exist, so we need to load that module.


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

To see the value for any of these variables, use the `echo` command:

```
xxx
```

[Back to Modules](#modules) <br>
[Back to Top](#top)
<br>

### Loading Modules During Login <a name="module-login-load"></a>
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
           if [ -z "$BASHRC_READ" ]; then
                        export BASHRC_READ=1
                        # Place any module commands here
                   # module load hdf5
                fi
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
if [ -z "$BASHRC_READ" ]; then
   export BASHRC_READ=1
   # Place any module commands here
   module load hdf5
Fi
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
[Back to Modules](#modules) <br>
[Back to Top](#top)

### Troubleshooting:Module Error<a name="module-error"></a>

Sometimes this error is encountered when switching from one shell to another or attempting to run the module command from within a shell script or batch job. The module command may not be inherited between the shells.  To keep this from happening, execute the following command:


```
[expanse-ln3:~]source /etc/profile.d/modules.sh
```
OR add this command to your shell script (including Slurm batch scripts)

[Back to Modules](#modules) <br>
[Back to Top](#top)
<hr>



## <a name="accounts"></a>Managing Accounts on Expanse
This section focuses on how to manage your allocations on Expanse. For full details, see the [Expanse User Guide.](https://www.sdsc.edu/support/user_guides/expanse.html#accounts)

<a name="top"> In this Section:
* [Expanse Accounts](#expanse-accounts)
* [Logging Onto Expanse](#expanse-logon)
* [Obtaining Example Code](#example-code)
* [Expanse User Portal](#user-portal)

### Expanse Accounts<a name="expanse-accounts"></a>
You must have a expanse account in order to access the system.
* To obtain a trial account or an expedited allocation, go here:  http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts
* To obtain a trial account or an expedited allocation, go here:  http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts
* *Note:* You may need to create an XSEDE portal account. XSEDE portal accounts are open to the general community. However, access and allocations to specific XSEDE or SDSC systems will depend on the details of an allocation request.

### Logging Onto Expanse<a name="expanse-logon"></a>

Expanse supports *Single Sign-On* through the [XSEDE User Portal](https://portal.xsede.org), from the command line using an XSEDE-wide password. While CPU and GPU resources are allocated separately, the ```login``` nodes are the same. To log in to Expanse from the command line, use the hostname:

```
login.expanse.sdsc.edu
```

The following are examples of Secure Shell (ssh) commands that may be used to log in to Expanse:

```
ssh <your_username>@login.expanse.sdsc.edu
ssh -l <your_username> login.expanse.sdsc.edu
```


* Details about how to access Expanse under different circumstances are described in the Expanse User Guide:  https://www.sdsc.edu/support/user_guides/expanse.html#access

* For instructions on how to use SSH,
see our tutorial: [Connecting to SDSC HPC Systems Guide](https://github.com/sdsc-hpc-training-org/hpc-security/tree/master/connecting-to-hpc-systems).

* Below is an example of the logon message – often called the *MOTD* (message of the day, located in /etc/motd). This has not been implemented at this point on Expanse

```
[username@localhost:~] ssh expanse.sdsc.edu
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

####
Example of a terminal connection/Unix login session:

```
(base) localhost:~ username$ ssh -l username login.expanse.sdsc.edu
Last login: Wed Oct  7 11:04:17 2020 from 76.176.117.51
[username@login02 ~]$
[username@login02 ~]$ whoami
username
[username@login02 ~]$
[username@login02 ~]$ pwd
/home/username
[username@login02 ~]$
[username@login02 ~]$
```

[Back to Top](#top)
<hr>

### Obtaining Tutorial Example Code<a name="example-code"></a>
We will be clone the example code from GitHub repository located here:
https://github.com/sdsc-hpc-training-org/expanse-101

The example below will be for anonymous HTTPS downloads

* Create a test directory hold the expanse example files:


```
localhost:hpctrain username$ git clone https://github.com/sdsc-hpc-training-org/expanse-101.git
Cloning into 'expanse-101'...
remote: Enumerating objects: 79, done.
remote: Counting objects: 100% (79/79), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 302 (delta 36), reused 39 (delta 15), pack-reused 223
Receiving objects: 100% (302/302), 3.70 MiB | 4.66 MiB/s, done.
Resolving deltas: 100% (130/130), done.
localhost:hpctrain username$ ll
total 0
drwxr-xr-x   3 username  staff   96 Nov 18 08:12 .
drwxr-xr-x  11 username  staff  352 Nov 18 08:11 ..
drwxr-xr-x  10 username  staff  320 Nov 18 08:12 expanse-101
localhost:hpctrain username$ cd expanse-101/
localhost:expanse-101 username$ ls -al
total 48
drwxr-xr-x  10 username  staff   320 Nov 18 08:12 .
drwxr-xr-x   3 username  staff    96 Nov 18 08:12 ..
-rw-r--r--   1 username  staff  6148 Nov 18 08:12 .DS_Store
drwxr-xr-x  12 username  staff   384 Nov 18 08:12 .git
-rw-r--r--   1 username  staff   459 Nov 18 08:12 .gitignore
-rw-r--r--   1 username  staff  1005 Nov 18 08:12 README.md
drwxr-xr-x   4 username  staff   128 Nov 18 08:12 docs
drwxr-xr-x   7 username  staff   224 Nov 18 08:12 examples
drwxr-xr-x  12 username  staff   384 Nov 18 08:12 images
-rw-r--r--   1 username  staff  5061 Nov 18 08:12 running_jobs_on_expanse.md
```

*Note*: you can learn to create and modify directories as part of the *Getting Started* and *Basic Skills* preparation found here:
https://github.com/sdsc-hpc-training-org/basic_skills

The examples directory contains the code we will cover in this tutorial:

```

[username@login01 examples]$ ls -al examples
total 88
drwxr-xr-x 6 username use300 6 Oct  7 14:15 .
drwxr-xr-x 5 username use300 8 Oct  7 14:15 ..
drwxr-xr-x 2 username use300 6 Oct  7 14:15 HYBRID
drwxr-xr-x 2 username use300 6 Oct  7 14:15 MPI
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OpenACC
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OPENMP
[username@login01 examples]$ ls -al examples/MPI
total 63
drwxr-xr-x 2 username use300     6 Oct  7 14:15 .
drwxr-xr-x 6 username use300     6 Oct  7 14:15 ..
-rwxr-xr-x 1 username use300 21576 Oct  7 14:15 hello_mpi
-rw-r--r-- 1 username use300   329 Oct  7 14:15 hello_mpi.f90
-rw-r--r-- 1 username use300   464 Oct  7 14:15 hellompi-slurm.sb
-rw-r--r-- 1 username use300   181 Oct  7 14:15 README.txt

```
All examples will contain source code, along with a batch script example so you can compile and run all examples on Expanse.

### Expanse User Portal<a name="user-portal"></a>
<img src="images/expanse_usesr_portal.png" alt="Expanse User Portal" width="400px" />

* See: https://portal.expanse.sdsc.edu
* Quick and easy way for Expanse users to login, transfer and edit files and submit and monitor jobs.
* Gateway for launching interactive applications such as MATLAB, Rstudio
* Integrated web-based environment for file management and job submission.
* All Users with valid Expanse Allocation and XSEDE Based credentials have access via their XSEDE credentials..


[Back to Top](#top)
<hr>

## <a name="compilers"></a>Compiling & Linking Code

<a name="top"> In this Section:
* [Compiling & Linking](#compilers)
    * [Supported Compiler Types](#compilers-supported)
    * [Using the AMD Compilers](#compilers-intel)
    * [Using the Intel Compilers](#compilers-intel)
    * [Using the PGI Compilers](#compilers-pgi)
    * [Using the GNU Compilers](#compilers-gnu)


### <a name="compilers"></a>Expanse Compilers

Expanse provides the Intel, Portland Group (PGI), and GNU compilers along with multiple MPI implementations (MVAPICH2, MPICH2, OpenMPI). Most applications will achieve the best performance on Expanse using the Intel compilers and MVAPICH2 and the majority of libraries installed on Expanse have been built using this combination.

Other compilers and versions can be installed by Expanse staff on request. For more information, see the [Expanse User Guide.]
(https://www.sdsc.edu/support/user_guides/expanse.html#compiling)

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

[Back to Top](#top)
<hr>

### <a name="compilers-amd"></a>Using the AMD compilers

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

[Back to Top](#top)
<hr>

### <a name="compilers-intel"></a>Using the Intel Compilers:

The Intel compilers and the MVAPICH2 MPI implementation will be loaded by default. If you have modified your environment, you can reload by executing the following commands at the Linux prompt or placing in your startup file (~/.cshrc or ~/.bashrc) or into a module load script (see above).

```
module purge
module load intel mvapich2_ib
```
For AVX2 support, compile with the -xHOST option. Note that -xHOST alone does not enable aggressive optimization, so compilation with -O3 is also suggested. The -fast flag invokes -xHOST, but should be avoided since it also turns on interprocedural optimization (-ipo), which may cause problems in some instances.

Intel MKL libraries are available as part of the "intel" modules on Expanse. Once this module is loaded, the environment variable MKL_ROOT points to the location of the mkl libraries. The MKL link advisor can be used to ascertain the link line (change the MKL_ROOT aspect appropriately).

In the example below, we are working with the HPC examples that can be found in

```
[user@expanse-14-01:~/expanse-examples/expanse101/MKL] pwd
/home/user/expanse-examples/expanse101/MKL
[user@expanse-14-01:~/expanse-examples/expanse101/MKL] ls -al
total 25991
drwxr-xr-x  2 user use300        9 Nov 25 17:20 .
drwxr-xr-x 16 user use300       16 Aug  5 19:02 ..
-rw-r--r--  1 user use300      325 Aug  5 19:02 compile.txt
-rw-r--r--  1 user use300     6380 Aug  5 19:02 pdpttr.c
-rwxr-xr-x  1 user use300 44825440 Nov 25 16:55 pdpttr.exe
-rw-r--r--  1 user use300      188 Nov 25 16:57 scalapack.20294236.expanse-07-27.out
-rw-r--r--  1 user use300      376 Aug  5 19:02 scalapack.sb
```

The file `compile.txt` contains the full command to compile the `pdpttr.c` program statically linking 64 bit scalapack libraries on Expanse:

```
[user@expanse-14-01:~/expanse-examples/expanse101/MKL] cat compile.txt
mpicc -o pdpttr.exe pdpttr.c /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_intel_lp64.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_sequential.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_core.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -ldl
```

Run the command:


```
[user@expanse-14-01:~/expanse-examples/expanse101/MKL] mpicc -o pdpttr.exe pdpttr.c  -I$MKL_ROOT/include ${MKL_ROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKL_ROOT}/lib/intel64/libmkl_intel_lp64.a ${MKL_ROOT}/lib/intel64/libmkl_core.a ${MKL_ROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group ${MKL_ROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -lpthread -lm
```

For more information on the Intel compilers run: [ifort | icc | icpc] -help

[Back to Top](#top)
<hr>

### <a name="compilers-pgi"></a>Using the PGI Compilers
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

[Back to Top](#top)
<hr>

### <a name="compilers-gnu"></a>Using the GNU Compilers
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


[Back to Top](#top)
<hr>
