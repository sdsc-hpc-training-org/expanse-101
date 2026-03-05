## Environment Modules: Customizing Your User Environment
The Environment Modules package provides for dynamic modification of your shell environment. Module commands set, change, or delete environment variables, typically in support of a particular application. They also let the user choose between different versions of the same software or different combinations of related codes. See the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#modules).

---
### Introduction to the Lua Lmod Module System
* Expanse uses Lmod, a Lua based module system.
   * See: [https://lmod.readthedocs.io/en/latest/010_user.html](https://lmod.readthedocs.io/en/latest/010_user.html)
* Users setup custom environments by loading available modules into the shell environment, including needed compilers and libraries and the batch scheduler.
* What’s the same as Comet:
  * Dynamic modification of your shell environment
  * User can set, change, or delete environment variables
  * User chooses between different versions of the same software or different combinations of related codes.
* Modules: What’s Different?
  * *Users will need to load the scheduler (e.g. Slurm)*
  * Depending on which hardware users are working on, *users will need to load either the ```gpu``` or ```cpu``` modules*.
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



---
### Modules: Popular Lmod Commands

Here are some common module commands and their descriptions:

| Lmod Command | Description |
|:--- | :--- |
|module purge | Remove all modules that are currently loaded|
|module list | List the modules that are currently loaded|
|module avail | List the modules that are available in environment|
|module spider | List of the modules and extensions currently available|
|module display <module_name> | Show the environment variables used by <module name> and how they are affected|
|module unload <module name> | Remove <module name> from the environment|
|module load <module name> | Load <module name> into the environment|
|module swap <module one> <module two> | Replace <module one> with <module two> in the environment|
|module  save <name> | Save the current list of modules to "name" collection. |
| savelist | List of saved module collections. |
|  describe  <name> | Describe the contents of a module collection. |
|module help | Get a list of all the commands that module knows about do:

Lmod commands support *short-hand* notation, for example:

```
   ml foo == module load foo
   ml -bar”  == module unload bar
```
*SDSC Guidance:   `add module calls to your environment and batch scripts`*



** A few module command examples:**

* Default environment for a new user/new login: `list`, `li`

```
[username@login01] expanse-101]$ module list
Currently Loaded Modules:
1) shared   2) slurm/expanse/20.02.3   3) cpu/0.15.4   4) DefaultModules
```

* List available modules:  `available`, `avail`, `av`

```
$ module av
[username@expanse-ln3:~] module av
[username@login01] expanse-101]$ module available

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

*Note:* Module defaults are chosen based on *Find First Rules* due to Name/Version/Version modules found in the module tree.
See https://lmod.readthedocs.io/en/latest/060_locating.html for details.

Use ```module spider``` to find all possible modules and extensions.

```
[username@login02 ~]$ module spider MPI
[username@login01] hpctr-examples]$ module spider MPI

----------------------------------------------------------------------------
  intel-mpi: intel-mpi/2019.8.254
----------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "intel-mpi/2019.8.254" module is available to load.

      cpu/0.15.4  gcc/10.2.0
      cpu/0.15.4  gcc/9.2.0
      cpu/0.15.4  intel/19.1.1.217
      gpu/0.15.4
      gpu/0.15.4  intel/17.0.7
      gpu/0.15.4  intel/19.0.5.281
      gpu/0.15.4  pgi/20.4
 
    Help:
      Intel MPI


----------------------------------------------------------------------------
  intel-mpi/2019.10.317:
----------------------------------------------------------------------------
     Versions:
        intel-mpi/2019.10.317/ezrfjne
        intel-mpi/2019.10.317/jhyxn2g
        intel-mpi/2019.10.317/kdx4qap
        intel-mpi/2019.10.317/uwgziob

----------------------------------------------------------------------------
  For detailed information about a specific "intel-mpi/2019.10.317" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider intel-mpi/2019.10.317/uwgziob
----------------------------------------------------------------------------

----------------------------------------------------------------------------
  mpip: mpip/3.4.1
----------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "mpip/3.4.1" module is available to load.

      cpu/0.15.4  gcc/10.2.0  openmpi/4.0.4
      cpu/0.15.4  gcc/10.2.0  openmpi/4.0.4-openib
 
    Help:
      mpiP: Lightweight, Scalable MPI Profiling
----------------------------------------------------------------------------
  mpip/3.5:
----------------------------------------------------------------------------
     Versions:
        mpip/3.5/aowedam
        mpip/3.5/blkwu65
        mpip/3.5/mjhw2bi
        mpip/3.5/o2hhyev
        mpip/3.5/owpz5hl
        mpip/3.5/plw5vw6
        mpip/3.5/useousx
        mpip/3.5/w64qya2
        mpip/3.5/x4p5f6i
        mpip/3.5/3g6o4ug
        mpip/3.5/7nngdrh

----------------------------------------------------------------------------
  For detailed information about a specific "mpip/3.5" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider mpip/3.5/7nngdrh
----------------------------------------------------------------------------

----------------------------------------------------------------------------
  openmpi:
----------------------------------------------------------------------------
     Versions:
        openmpi/3.1.6-cxx
        openmpi/3.1.6-threads
        openmpi/3.1.6
        openmpi/4.0.4-nocuda
        openmpi/4.0.4-openib
        openmpi/4.0.4
        openmpi/4.0.5
        openmpi/4.1.1

----------------------------------------------------------------------------
  For detailed information about a specific "openmpi" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider openmpi/4.1.1
----------------------------------------------------------------------------

----------------------------------------------------------------------------
  openmpi/4.1.1: openmpi/4.1.1/ygduf2r
----------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "openmpi/4.1.1/ygduf2r" module is available to load.

      cpu/0.17.3b  gcc/10.2.0/npcyll4
 
    Help:
      An open source Message Passing Interface implementation. The Open MPI
      Project is an open source Message Passing Interface implementation that
      is developed and maintained by a consortium of academic, research, and
      industry partners. Open MPI is therefore able to combine the expertise,
      technologies, and resources from all across the High Performance
      Computing community in order to build the best MPI library available.
      Open MPI offers advantages for system and software vendors, application
      developers and computer science researchers.
  ----------------------------------------------------------------------------
  openmpi/4.1.3:
----------------------------------------------------------------------------
     Versions:
        openmpi/4.1.3/gzzscfu
        openmpi/4.1.3/luhyajc
        openmpi/4.1.3/oq3qvsv
        openmpi/4.1.3/u2lt4pl
        openmpi/4.1.3/v2ei3ge
        openmpi/4.1.3/xigazqd

----------------------------------------------------------------------------
  For detailed information about a specific "openmpi/4.1.3" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider openmpi/4.1.3/xigazqd
----------------------------------------------------------------------------

----------------------------------------------------------------------------
  openmpi/mlnx/gcc/64: openmpi/mlnx/gcc/64/4.1.5a1
----------------------------------------------------------------------------

    This module can be loaded directly: module load openmpi/mlnx/gcc/64/4.1.5a1

    Help:
        Adds OpenMPI to your environment variables,
----------------------------------------------------------------------------
  py-mpi4py: py-mpi4py/3.0.3
----------------------------------------------------------------------------
    You will need to load all module(s) on any one of the lines below before the "py-mpi4py/3.0.3" module is available to load.

      cpu/0.15.4  gcc/10.2.0  mvapich2/2.3.6
      cpu/0.15.4  gcc/10.2.0  openmpi/4.0.4
      cpu/0.15.4  gcc/10.2.0  openmpi/4.0.4-openib
      gpu/0.15.4  openmpi/4.0.4
 
    Help:
      This package provides Python bindings for the Message Passing Interface
      (MPI) standard. It is implemented on top of the MPI-1/MPI-2
      specification and exposes an API which grounds on the standard MPI-2 C++
      bindings.
----------------------------------------------------------------------------
  py-mpi4py/3.1.2:
----------------------------------------------------------------------------
     Versions:
        py-mpi4py/3.1.2/cllp7nt
        py-mpi4py/3.1.2/kas2whp
        py-mpi4py/3.1.2/silsqln
        py-mpi4py/3.1.2/3lfjrdm
        py-mpi4py/3.1.2/7ebfcgr
----------------------------------------------------------------------------
  For detailed information about a specific "py-mpi4py/3.1.2" package (including how to load the modules) use the module's full name. Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider py-mpi4py/3.1.2/7ebfcgr
----------------------------------------------------------------------------     
```

---
### Load and Check Modules and Environment
In this example, we will add the Slurm library, and and verify that it is in your environment
* Check  module environment after logging on to the system
* Note: the module environment can change, depending on when different libraries are updated.

```
[username@login01] ~]$ module li

Currently Loaded Modules:
  1) shared            3) slurm/expanse/21.08.8   5) DefaultModules
  2) cpu/0.17.3b (c)   4) sdsc/1.0

  Where:
   c:  built natively for AMD Rome
```

* Note that MPI is not in the environment. Check environment looking for MPI commands


```
[username@login01] ~]$ which mpicc
/usr/bin/which: no mpicc in (/cm/shared/apps/sdsc/1.0/bin:/cm/shared/apps/sdsc/1.0/sbin:/cm/shared/apps/slurm/current/sbin:/cm/shared/apps/slurm/current/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin)
```

* Since MPI commands do not appear in our environment, we need to load that module:


```
[username@login01] hpctr-examples]$ module spider openmpi/4.1.1

----------------------------------------------------------------------------
  openmpi/4.1.1: openmpi/4.1.1/ygduf2r
----------------------------------------------------------------------------

    You will need to load all module(s) on any one of the lines below before the "openmpi/4.1.1/ygduf2r" module is available to load.

      cpu/0.17.3b  gcc/10.2.0/npcyll4
 
    Help:
      An open source Message Passing Interface implementation. The Open MPI
      Project is an open source Message Passing Interface implementation that
      is developed and maintained by a consortium of academic, research, and
      industry partners. Open MPI is therefore able to combine the expertise,
      technologies, and resources from all across the High Performance
      Computing community in order to build the best MPI library available.
      Open MPI offers advantages for system and software vendors, application
      developers and computer science researchers.

```
* load the modules above
  
```
[username@login01] hpctr-examples]$ module load cpu/0.17.3b  gcc/10.2.0/npcyll4
[username@login01] hpctr-examples]$ module list

Currently Loaded Modules:
  1) shared                  3) sdsc/1.0         5) cpu/0.17.3b        (c)
  2) slurm/expanse/21.08.8   4) DefaultModules   6) gcc/10.2.0/npcyll4

  Where:
   c:  built natively for AMD Rome

 

[username@login01] hpctr-examples]$ which mpicc
/usr/bin/which: no mpicc in (/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen/gcc-8.5.0/gcc-10.2.0-npcyll4gxjhf4tejksmdzlsl3d3usqpd/bin:/cm/shared/apps/sdsc/1.0/bin:/cm/shared/apps/sdsc/1.0/sbin:/cm/shared/apps/slurm/current/sbin:/cm/shared/apps/slurm/current/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin)
[username@login01] hpctr-examples]$ module load openmpi/4.1.1
[username@login01] hpctr-examples]$ module list

Currently Loaded Modules:
  1) shared                  5) cpu/0.17.3b           (c)
  2) slurm/expanse/21.08.8   6) gcc/10.2.0/npcyll4
  3) sdsc/1.0                7) ucx/1.10.1/dnpjjuc
  4) DefaultModules          8) openmpi/4.1.1/ygduf2r

  Where:
   c:  built natively for AMD Rome

 

[username@login01] hpctr-examples]$ which mpicc
/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpicc
```

* Notice the long and complicated file path. Try listing the contents of the directory will give you 45 directories. This is the motivation for Modules:

```
[username@login01] hpctr-examples]$ ls -al /cm/shared/apps
total 1
drwxr-xr-x 43 root root 42 Apr 14 09:22 .
drwxr-xr-x  8 root root  7 May  5  2022 ..
drwxr-xr-x  4 root root  2 Aug 18  2022 access
drwxr-xr-x  9 root root  8 Jun  1  2021 AMDuProf_3.4.475
drwxr-xr-x  3 root root  1 Aug 26  2020 blacs
drwxr-xr-x  3 root root  1 Aug 26  2020 blas
[SNIP]
drwxr-xr-x  3 root root  1 Jun 21  2022 uge
drwxr-xr-x  3 root root  1 Jul 31  2021 vis
drwxr-xr-x  5 root root  3 Oct 19  2020 xsede

```
* Display loaded module details:
  
```
[username@login01] hpctr-examples]$ module display openmpi/4.1.1/ygduf2r
----------------------------------------------------------------------------
   /cm/shared/apps/spack/0.17.3/cpu/b/share/spack/lmod/linux-rocky8-x86_64/gcc/10.2.0/openmpi/4.1.1/ygduf2r.lua:
----------------------------------------------------------------------------
whatis("Name : openmpi")
whatis("Version : 4.1.1")
whatis("Target : zen2")
whatis("Short description : An open source Message Passing Interface implementation.")
[SNIP]
Project is an open source Message Passing Interface implementation that
is developed and maintained by a consortium of academic, research, and
industry partners. Open MPI is therefore able to combine the expertise,
technologies, and resources from all across the High Performance
Computing community in order to build the best MPI library available.
Open MPI offers advantages for system and software vendors, application
developers and computer science researchers.]])
family("mpi")
prepend_path("MODULEPATH","/cm/shared/apps/spack/0.17.3/cpu/b/share/spack/lmod/linux-rocky8-x86_64/openmpi/4.1.1-ygduf2r/gcc/10.2.0")
setenv("LMOD_MPI_NAME","openmpi")
setenv("LMOD_MPI_VERSION","4.1.1-ygduf2r")
prepend_path("LD_LIBRARY_PATH","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/lib")
prepend_path("PATH","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin")
prepend_path("MANPATH","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/share/man")
prepend_path("PKG_CONFIG_PATH","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/lib/pkgconfig")
prepend_path("CMAKE_PREFIX_PATH","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/")
setenv("MPICC","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpicc")
setenv("MPICXX","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpic++")
setenv("MPIF77","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpif77")
setenv("MPIF90","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpif90")
setenv("OPENMPIHOME","/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv")


```

Once you have loaded the modules, you can check the system variables that are available for you to use.
* To see all variable, run the **`env`** command. For the environment that we created, the command below produced 107 lines containing information such as your login name, shell, your home directory, and paths to the different libraries and modules that you have loaded:


```
[username@login01] hpctr-examples]$ env
LS_COLORS=rs=0:di=38;5;33:ln=38;5;51:mh=00:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=01;05;37;41:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:[SNIP]
__LMOD_REF_COUNT_PATH=/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin:1;/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/ucx-1.10.1-dnpjjucppo5hjn4wln4bbekczzk7covs/bin:1;/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen/gcc-8.5.0/gcc-10.2.0-npcyll4gxjhf4tejksmdzlsl3d3usqpd/bin:1;/cm/shared/apps/sdsc/1.0/bin:1;/cm/shared/apps/sdsc/1.0/sbin:1;/cm/shared/apps/slurm/current/sbin:1;/cm/shared/apps/slurm/current/bin:1;/usr/local/bin:1;/usr/bin:1;/usr/local/sbin:1;/usr/sbin:1
[SNIP]
MPICXX=/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpic++
[SNIP]
PWD=/home/username/hpc-onboard/hpctr-examples
ENABLE_LMOD=1
HOME=/home/username
[SNIP]
__LMOD_REF_COUNT_LIBRARY_PATH=/cm/shared/apps/slurm/current/lib64/slurm:1;/cm/shared/apps/slurm/current/lib64:1
OPENMPIHOME=/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv
LIBRARY_PATH=/cm/shared/apps/slurm/current/lib64/slurm:/cm/shared/apps/slurm/current/lib64
[SNIP]
MPIF77=/cm/shared/apps/spack/0.17.3/cpu/b/opt/spack/linux-rocky8-zen2/gcc-10.2.0/openmpi-4.1.1-ygduf2ryo2scwdtpl4wftbmlz2xubbrv/bin/mpif77
SDSC_SBIN=/cm/shared/apps/sdsc/1.0/sbin

[SNIP]
LMOD_FAMILY_MPI=openmpi/4.1.1
BASH_FUNC_which%%=() {  ( alias;
 eval ${which_declare} ) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}
BASH_FUNC_module%%=() {  eval $($LMOD_CMD bash "$@") && eval $(${LMOD_SETTARG_CMD:-:} -s sh)
}
BASH_FUNC_ml%%=() {  eval $($LMOD_DIR/ml_cmd "$@")
}
_=/usr/bin/env
[username@login01] hpctr-examples]$


```

To see the value for any of these variables, use the `echo` command. In this example we show how to activate your miniconda environment so you can run Jupyter Notebooks:

```
[username@login01] hpctr-examples]$ echo $LMOD_FAMILY_MPI
openmpi/4.1.1
```

---
### Loading Modules at Login 
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
[username@login01] ~]$
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
[username@login02 ~]$ env | grep Slurm
[snip]
MANPATH=/cm/shared/apps/Slurm/current/man:/usr/share/lmod/lmod/share/man:/usr/local/share/man:/usr/share/man:/cm/local/apps/environment-modules/current/share/man
PATH=/cm/shared/apps/Slurm/current/sbin:/cm/shared/apps/Slurm/current/bin:/home/user/miniconda3/bin/conda:/home/user/miniconda3/bin:/home/user/miniconda3/condabin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin:/home/user/.local/bin:/home/user/bin
[snip]
[username@login02 ~]$ which squeue
/cm/shared/apps/Slurm/current/bin/squeue
```
---
### [Saving Module Schemes]]
* Lmod allows a you to save a bundle of modules as a collection using module save <collection_name> and module restore <collection_name>.
* This enables you to quickly get the same list of modules loaded if you tend to use the same modules over and over.
* With a new module scheme comes a different system MODULEPATH.

```
[mthomas@login01 hpctr-examples]$ module save tutorial-openmpi-list
Saved current collection of modules to: "tutorial-openmpi-list"
```
* To see what is saved:

```
[mthomas@login01 hpctr-examples]$ module savelist
Named collection list :
  1) tutorial-openmpi-list
```


### [Troubleshooting]

#### Troubleshooting: Lmod warning “rebuild your saved collection”
* With each new module scheme comes a different system MODULEPATH. For this reason, if you have some module collections saved, you may experience the following warning: “Lmod Warning: The system MODULEPATH has changed: please rebuild your saved collection.” To solve this you need to remove your old collections and create them again.

* Too see the list of module collections that you currently have:

```
[mthomas@login01 hpctr-examples]$ module savelist
Named collection list :
  1) tutorial-openmpi-list

```

* To remove or disable a saved collection:

```
[username@login02 ~]$ module disable tutorial-openmpi-list
Disabling tutorial-openmpi-list collection by renaming with a "~"
[username@login02 ~]$ module savelist
No named collections.
[username@login02 ~]$
```

#### Troubleshooting:  Module Error

Sometimes this error is encountered when switching from one shell to another or attempting to run the module command from within a shell script or batch job. The module command may not be inherited between the shells.  To keep this from happening, execute the following command:


```
[expanse-ln3:~]source /etc/profile.d/modules.sh
```
OR add this command to your shell script (including Slurm batch scripts)

---
