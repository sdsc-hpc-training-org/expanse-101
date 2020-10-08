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

Misc Notes/Updates:
===================

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

.. raw:: html

   <hr>

`Back to Top <#top>`__

.. raw:: html

   <hr>

 \* Lustre filesystems – Good for scalable large block I/O \* Accessible
from all compute and GPU nodes. \* /oasis/scratch/expanse - 2.5PB, peak
performance: 100GB/s. Good location for storing large scale scratch data
during a job. \* /oasis/projects/nsf - 2.5PB, peak performance: 100
GB/s. Long term storage. \* *Not good for lots of small files or small
block I/O.*

-  SSD filesystems

   -  /scratch local to each native compute node – 210GB on regular
      compute nodes, 285GB on GPU, large memory nodes, 1.4TB on selected
      compute nodes.
   -  SSD location is good for writing small files and temporary scratch
      files. Purged at the end of a job.

-  Home directories (/home/$USER)

   -  Source trees, binaries, and small input files.
   -  *Not good for large scale I/O.*

`Back to Top <#top>`__

.. raw:: html

   <hr>

Getting Started on Expanse
--------------------------

Expanse Accounts
~~~~~~~~~~~~~~~~

You must have a expanse account in order to access the system. \* Obtain
a trial account here:
http://www.sdsc.edu/support/user_guides/expanse.html#trial_accounts \*
You can use your XSEDE account.

Logging Onto Expanse
~~~~~~~~~~~~~~~~~~~~

Details about how to access Expanse under different circumstances are
described in the Expanse User Guide:
http://www.sdsc.edu/support/user_guides/expanse.html#access

For instructions on how to use SSH, see
`here <https://github.com/sdsc/sdsc-summer-institute-2020/tree/master/0_preparation/connecting-to-hpc-systems>`__

::

   [mthomas@gidget:~] ssh -Y expanse.sdsc.edu
   Password:
   Last login: Fri Jul 31 14:20:40 2020 from 76.176.117.51
   Rocks 7.0 (Manzanita)
   Profile built 12:32 03-Dec-2019

   Kickstarted 13:47 03-Dec-2019

                         WELCOME TO
         __________________  __  _______________
           -----/ ____/ __ \/  |/  / ____/_  __/
             --/ /   / / / / /|_/ / __/   / /
              / /___/ /_/ / /  / / /___  / /
              \____/\____/_/  /_/_____/ /_/
   ###############################################################################
   NOTICE:
   The Expanse login nodes are not to be used for running processing tasks.
   This includes running Jupyter notebooks and the like.  All processing
   jobs should be submitted as jobs to the batch scheduler.  If you don’t
   know how to do that see the Expanse user guide
   https://www.sdsc.edu/support/user_guides/expanse.html#running.
   Any tasks found running on the login nodes in violation of this policy
    may be terminated immediately and the responsible user locked out of
   the system until they contact user services.
   ###############################################################################
   (base) [mthomas@expanse-ln2:~]

`Back to Top <#top>`__

.. raw:: html

   <hr>

Obtaining Example Code
~~~~~~~~~~~~~~~~~~~~~~

-  Create a test directory hold the expanse example files:

::

   [expanse-ln2 ~]$ mkdir expanse-examples
   [expanse-ln2 ~]$ ls -al
   total 166
   drwxr-x---   8 user user300    24 Jul 17 20:20 .
   drwxr-xr-x 139 root    root       0 Jul 17 20:17 ..
   -rw-r--r--   1 user use300  2487 Jun 23  2017 .alias
   -rw-------   1 user use300 14247 Jul 17 12:11 .bash_history
   -rw-r--r--   1 user use300    18 Jun 19  2017 .bash_logout
   -rw-r--r--   1 user use300   176 Jun 19  2017 .bash_profile
   -rw-r--r--   1 user use300   159 Jul 17 18:24 .bashrc
   drwxr-xr-x   2 user use300     2 Jul 17 20:20 expanse-examples
   [snip extra lines]
   [expanse-ln2 ~]$ cd expanse-examples/
   [expanse-ln2 expanse-examples]$ pwd
   /home/user/expanse-examples
   [expanse-ln2 expanse-examples]$

-  Copy the ``/share/apps/examples/expanse101/`` directory to your local
   (``/home/username/expanse-examples``) directory. Note: you can learn
   to create and modify directories as part of the *Getting Started* and
   *Basic Skills* preparation work:
   https://github.com/sdsc/sdsc-summer-institute-2020/tree/master/0_preparation

::

   [mthomas@expanse-ln3 ~]$ ls -al /share/apps/examples/hpc-training/expanse-examples/
   total 20
   (base) [mthomas@expanse-ln2:~/expanse101] ll /share/apps/examples/hpc-training/expanse101/
   total 32
   drwxr-sr-x 8 mthomas  use300 4096 Apr 16 10:39 .
   drwxrwsr-x 4 mahidhar use300 4096 Apr 15 23:37 ..
   drwxr-sr-x 5 mthomas  use300 4096 Apr 16 03:30 CUDA
   drwxr-sr-x 2 mthomas  use300 4096 Apr 16 10:39 HYBRID
   drwxr-sr-x 2 mthomas  use300 4096 Apr 16 10:39 jupyter_notebooks
   drwxr-sr-x 2 mthomas  use300 4096 Apr 16 16:46 MKL
   drwxr-sr-x 4 mthomas  use300 4096 Apr 16 03:30 MPI
   drwxr-sr-x 2 mthomas  use300 4096 Apr 16 03:31 OPENMP

Copy the ‘expanse101’ directory into your ``expanse-examples``
directory:

::

   [mthomas@expanse-ln3 ~]$
   [mthomas@expanse-ln3 ~]$ cp -r /share/apps/examples/expanse101/ expanse-examples/
   [mthomas@expanse-ln3 ~]$ ls -al expanse-examples/
   total 105
   drwxr-xr-x  5 username use300   6 Aug  5 19:02 .
   drwxr-x--- 10 username use300  27 Aug  5 17:59 ..
   drwxr-xr-x 16 username use300  16 Aug  5 19:02 expanse101
   [mthomas@expanse-ln3 expanse-examples]$ ls -al
   total 132
   total 170
   drwxr-xr-x  8 mthomas use300  8 Aug  3 01:19 .
   drwxr-x--- 64 mthomas use300 98 Aug  3 01:19 ..
   drwxr-xr-x  5 mthomas use300  5 Aug  3 01:19 CUDA
   drwxr-xr-x  2 mthomas use300  6 Aug  3 01:19 HYBRID
   drwxr-xr-x  2 mthomas use300  3 Aug  3 01:19 jupyter_notebooks
   drwxr-xr-x  2 mthomas use300  6 Aug  3 01:19 MKL
   drwxr-xr-x  4 mthomas use300  9 Aug  3 01:19 MPI
   drwxr-xr-x  2 mthomas use300  9 Aug  3 01:19 OPENMP

Most examples will contain source code, along with a batch script
example so you can run the example, and compilation examples (e.g. see
the MKL example).

`Back to Top <#top>`__

.. raw:: html

   <hr>

Modules: Customizing Your User Environment
------------------------------------------

The Environment Modules package provides for dynamic modification of
your shell environment. Module commands set, change, or delete
environment variables, typically in support of a particular application.
They also let the user choose between different versions of the same
software or different combinations of related codes. See:
http://www.sdsc.edu/support/user_guides/expanse.html#modules

Common module commands
~~~~~~~~~~~~~~~~~~~~~~

Here are some common module commands and their descriptions:

+-----------------------------------+-----------------------------------+
| Command                           | Description                       |
+===================================+===================================+
| module list                       | List the modules that are         |
|                                   | currently loaded                  |
+-----------------------------------+-----------------------------------+
| module avail                      | List the modules that are         |
|                                   | available                         |
+-----------------------------------+-----------------------------------+
| module display                    | Show the environment variables    |
|                                   | used by and how they are affected |
+-----------------------------------+-----------------------------------+
| module show                       | Same as display                   |
+-----------------------------------+-----------------------------------+
| module unload                     | Remove from the environment       |
+-----------------------------------+-----------------------------------+
| module load                       | Load into the environment         |
+-----------------------------------+-----------------------------------+
| module swap                       | Replace with in the environment   |
+-----------------------------------+-----------------------------------+

 A few module commands:

-  Default environment: ``list``, ``li``

::

   [mthomas@expanse-ln3:~] module list
   Currently Loaded Modulefiles:
     1) intel/2018.1.163    2) mvapich2_ib/2.3.2

-  List available modules: ``available``, ``avail``, ``av``

::

   $ module av
   [mthomas@expanse-ln3:~] module av

   ------------------------- /opt/modulefiles/mpi/.intel --------------------------
   mvapich2_gdr/2.3.2(default)
   [snip]

   ------------------------ /opt/modulefiles/applications -------------------------
   abaqus/6.11.2                      lapack/3.8.0(default)
   abaqus/6.14.1(default)             mafft/7.427(default)
   abinit/8.10.2(default)             matlab/2019b(default)
   abyss/2.2.3(default)               matt/1.00(default)
   amber/18(default)                  migrate/3.6.11(default)
   . . .
   eos/3.7.1(default)                spark/1.2.0
   globus/6.0                         spark/1.5.2(default)
   . . .

`Back to Top <#top>`__

.. raw:: html

   <hr>

Load and Check Modules and Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Load modules:

::

   [mthomas@expanse-ln3:~] module list
   Currently Loaded Modulefiles:
     1) intel/2018.1.163    2) mvapich2_ib/2.3.2
   [mthomas@expanse-ln3:~] module add spark/1.2.0
   [mthomas@expanse-ln3:~] module list
   Currently Loaded Modulefiles:
     1) intel/2018.1.163    3) hadoop/2.6.0
     2) mvapich2_ib/2.3.2   4) spark/1.2.0

Show loaded module details:

::

   $ module show fftw/3.3.4
   [mthomas@expanse-ln3:~] module show spark/1.2.0
   -------------------------------------------------------------------
   /opt/modulefiles/applications/spark/1.2.0:

   module-whatis    Spark
   module-whatis    Version: 1.2.0
   module       load hadoop/2.6.0
   prepend-path     PATH /opt/spark/1.2.0/bin
   setenv       SPARK_HOME /opt/spark/1.2.0
   -------------------------------------------------------------------

Once you have loaded the modules, you can check the system variables
that are available for you to use. \* To see all variable, run the
\ ``env``\  command. Typically, you will see more than 60 lines
containing information such as your login name, shell, your home
directory:

::

   [mthomas@expanse-ln3 IBRUN]$ env
   SPARK_HOME=/opt/spark/1.2.0
   HOSTNAME=expanse-ln3.sdsc.edu
   INTEL_LICENSE_FILE=/opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/licenses:/opt/intel/licenses:/root/intel/licenses
   SHELL=/bin/bash
   USER=mthomas
   PATH=/opt/spark/1.2.0/bin:/opt/hadoop/2.6.0/sbin:/opt/hadoop/contrib/myHadoop/bin:/opt/hadoop/2.6.0/bin:/home/mthomas/miniconda3/bin:/home/mthomas/miniconda3/condabin:/opt/mvapich2/intel/ib/bin:/opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/bin/intel64:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/mthomas/bin
   PWD=/home/mthomas
   LOADEDMODULES=intel/2018.1.163:mvapich2_ib/2.3.2:hadoop/2.6.0:spark/1.2.0
   JUPYTER_CONFIG_DIR=/home/mthomas/.jupyter
   MPIHOME=/opt/mvapich2/intel/ib
   MODULESHOME=/usr/share/Modules
   MKL_ROOT=/opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl

To see the value for any of these variables, use the ``echo`` command:

::

   [mthomas@expanse-ln3 IBRUN]$ echo $PATH
   PATH=/opt/gnu/gcc/bin:/opt/gnu/bin:/opt/mvapich2/intel/ib/bin:/opt/intel/composer_xe_2013_sp1.2.144/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/mpirt/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/debugger/gdb/intel64_mic/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/home/username/bin

`Back to Top <#top>`__

.. raw:: html

   <hr>

Troubleshooting:Module Error
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes this error is encountered when switching from one shell to
another or attempting to run the module command from within a shell
script or batch job. The module command may not be inherited between the
shells. To keep this from happening, execute the following command:

::

   [expanse-ln3:~]source /etc/profile.d/modules.sh

OR add this command to your shell script (including Slurm batch scripts)

`Back to Top <#top>`__

.. raw:: html

   <hr>

Compiling & Linking
-------------------

Expanse provides the Intel, Portland Group (PGI), and GNU compilers
along with multiple MPI implementations (MVAPICH2, MPICH2, OpenMPI).
Most applications will achieve the best performance on Expanse using the
Intel compilers and MVAPICH2 and the majority of libraries installed on
Expanse have been built using this combination.

Other compilers and versions can be installed by Expanse staff on
request. For more information, see the user guide:
http://www.sdsc.edu/support/user_guides/expanse.html#compiling

Supported Compiler Types
~~~~~~~~~~~~~~~~~~~~~~~~

Expanse compute nodes support several parallel programming models: \*
**MPI**: Default: Intel \* Default Intel Compiler: intel/2018.1.163;
Other versions available. \* Other options: openmpi_ib/1.8.4 (and
1.10.2), Intel MPI, mvapich2_ib/2.1 \* mvapich2_gdr: GPU direct enabled
version \* **OpenMP**: All compilers (GNU, Intel, PGI) have OpenMP
flags. \* **GPU nodes**: support CUDA, OpenACC. \* **Hybrid modes** are
possible.

In this tutorial, we include several hands-on examples that cover many
of the cases in the table:

-  MPI
-  OpenMP
-  HYBRID
-  GPU
-  Local scratch

Default/Suggested Compilers to used based on programming model and
languages:

+---------+--------+--------+---------------+----------------+
|         | Serial | MPI    | OpenMP        | MPI+OpenMP     |
+=========+========+========+===============+================+
| Fortran | ifort  | mpif90 | ifort -openmp | mpif90 -openmp |
+---------+--------+--------+---------------+----------------+
| C       | icc    | mpicc  | icc -openmp   | mpicc -openmp  |
+---------+--------+--------+---------------+----------------+
| C++     | icpc   | mpicxx | icpc -openmp  | mpicxx -openmp |
+---------+--------+--------+---------------+----------------+

`Back to Top <#top>`__

.. raw:: html

   <hr>

Using the Intel Compilers:
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Intel compilers and the MVAPICH2 MPI implementation will be loaded
by default. If you have modified your environment, you can reload by
executing the following commands at the Linux prompt or placing in your
startup file (~/.cshrc or ~/.bashrc) or into a module load script (see
above).

::

   module purge
   module load intel mvapich2_ib

For AVX2 support, compile with the -xHOST option. Note that -xHOST alone
does not enable aggressive optimization, so compilation with -O3 is also
suggested. The -fast flag invokes -xHOST, but should be avoided since it
also turns on interprocedural optimization (-ipo), which may cause
problems in some instances.

Intel MKL libraries are available as part of the “intel” modules on
Expanse. Once this module is loaded, the environment variable MKL_ROOT
points to the location of the mkl libraries. The MKL link advisor can be
used to ascertain the link line (change the MKL_ROOT aspect
appropriately).

In the example below, we are working with the HPC examples that can be
found in

::

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

The file ``compile.txt`` contains the full command to compile the
``pdpttr.c`` program statically linking 64 bit scalapack libraries on
Expanse:

::

   [user@expanse-14-01:~/expanse-examples/expanse101/MKL] cat compile.txt
   mpicc -o pdpttr.exe pdpttr.c /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_intel_lp64.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_sequential.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_core.a /opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/mkl/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -lpthread -lm -ldl

Run the command:

::

   [user@expanse-14-01:~/expanse-examples/expanse101/MKL] mpicc -o pdpttr.exe pdpttr.c  -I$MKL_ROOT/include ${MKL_ROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKL_ROOT}/lib/intel64/libmkl_intel_lp64.a ${MKL_ROOT}/lib/intel64/libmkl_core.a ${MKL_ROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group ${MKL_ROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -lpthread -lm

For more information on the Intel compilers run: [ifort \| icc \| icpc]
-help

`Back to Top <#top>`__

.. raw:: html

   <hr>

Using the PGI Compilers
~~~~~~~~~~~~~~~~~~~~~~~

The PGI compilers can be loaded by executing the following commands at
the Linux prompt or placing in your startup file (~/.cshrc or ~/.bashrc)

::

   module purge
   module load pgi mvapich2_ib

For AVX support, compile with -fast

For more information on the PGI compilers: man [pgf90 \| pgcc \| pgCC]

+-------+--------+-----------+------------+------------+
|       | Serial | MPI       | OpenMP     | MPI+OpenMP |
+=======+========+===========+============+============+
| pgf90 | mpif90 | pgf90 -mp | mpif90 -mp |            |
+-------+--------+-----------+------------+------------+
| C     | pgcc   | mpicc     | pgcc -mp   | mpicc -mp  |
+-------+--------+-----------+------------+------------+
| C++   | pgCC   | mpicxx    | pgCC -mp   | mpicxx -mp |
+-------+--------+-----------+------------+------------+

`Back to Top <#top>`__

.. raw:: html

   <hr>

Using the GNU Compilers
~~~~~~~~~~~~~~~~~~~~~~~

The GNU compilers can be loaded by executing the following commands at
the Linux prompt or placing in your startup files (~/.cshrc or
~/.bashrc)

::

   module purge
   module load gnu openmpi_ib

For AVX support, compile with -mavx. Note that AVX support is only
available in version 4.7 or later, so it is necessary to explicitly load
the gnu/4.9.2 module until such time that it becomes the default.

For more information on the GNU compilers: man [gfortran \| gcc \| g++]

+---------+----------+--------+-------------------+-----------------+
|         | Serial   | MPI    | OpenMP            | MPI+OpenMP      |
+=========+==========+========+===================+=================+
| Fortran | gfortran | mpif90 | gfortran -fopenmp | mpif90 -fopenmp |
+---------+----------+--------+-------------------+-----------------+
| C       | gcc      | mpicc  | gcc -fopenmp      | mpicc -fopenmp  |
+---------+----------+--------+-------------------+-----------------+
| C++     | g++      | mpicxx | g++ -fopenmp      | mpicxx -fopenmp |
+---------+----------+--------+-------------------+-----------------+

`Back to Top <#top>`__

.. raw:: html

   <hr>

Running Jobs on Expanse 
------------------------

Expanse manages computational work via the Simple Linux Utility for
Resource Management (SLURM) batch environment. Expanse places limits on
the number of jobs queued and running on a per group (allocation) and
partition basis. Submitting a large number of jobs (especially very
short ones) can impact the overall scheduler response for all users. If
you are anticipating submitting a lot of jobs, contact the SDSC
consulting staff before you submit them. We can work to check if there
are bundling options that make your workflow more efficient and reduce
the impact on the scheduler

For more details, see the section on Running job in the Expanse User
Guide: http://www.sdsc.edu/support/user_guides/expanse.html#running

The Simple Linux Utility for Resource Management (SLURM) 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  “Glue” for parallel computer to schedule and execute jobs
-  Role: Allocate resources within a cluster

   -  Nodes (unique IP address)
   -  Interconnect/switches
   -  Generic resources (e.g. GPUs)
   -  Launch and otherwise manage jobs

-  Functionality:

   -  Prioritize queue(s) of jobs;
   -  decide when and where to start jobs;
   -  terminate job when done;
   -  Appropriate resources;
   -  Manage accounts for jobs

-  All jobs must be run via the Slurm scheduling infrastructure. There
   are two types of jobs:

   -  `Interactive Jobs <#running-jobs-slurm-interactive>`__
   -  `Batch Jobs <#running-jobs-slurm-batch-submit>`__

`Back to Top <#top>`__

.. raw:: html

   <hr>

Interactive Jobs: 
~~~~~~~~~~~~~~~~~~

Interactive HPC systems allow *real-time* user inputs in order to
facilitate code development, real-time data exploration, and
visualizations. An interactive job (also referred as interactive
session) will provide you with a shell on a compute node in which you
can launch your jobs. On Expanse, use the ``srun`` command:

::

   srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash

For more information, see the interactive computing tutorial
`here <https://github.com/sdsc/sdsc-summer-institute-2020/blob/master/0_preparation/interactive_computing/README.md>`__.

Batch Jobs using SLURM: 
~~~~~~~~~~~~~~~~~~~~~~~~

When you run in the batch mode, you submit jobs to be run on the compute
nodes using the ``sbatch`` command (described below).

Batch scripts are submitted from the login nodes. You can set
environment variables in the shell or in the batch script, including: \*
Partition (also called the qeueing system) \* Time limit for a job
(maximum of 48 hours; longer on request) \* Number of nodes, tasks per
node \* Memory requirements (if any) \* Job name, output file location
\* Email info, configuration

Below is an example of a basic batch script, which shows key features
including naming the job/output file, selecting the SLURM queue
partition, defining the number of nodes and ocres, and the length of
time that the job will need:

::

   [mthomas@expanse-ln3 IBRUN]$ cat hellompi-slurm.sb
   #!/bin/bash
   #SBATCH --job-name="hellompi"
   #SBATCH --output="hellompi.%j.%N.out"
   #SBATCH --partition=compute
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=24
   #SBATCH --export=ALL
   #SBATCH -t 00:30:00

   #Define user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib

   #This job runs with 2 nodes, 24 cores per node for a total of 48 cores.
   #ibrun in verbose mode will give binding detail

   ibrun -v ../hello_mpi

Note that we have included configuring the user environment by purging
and then loading the necessary modules. While not required, it is a good
habit to develop when building batch scripts.

`Back to Top <#top>`__

.. raw:: html

   <hr>

Slurm Partitions 
~~~~~~~~~~~~~~~~~

Expanse places limits on the number of jobs queued and running on a per
group (allocation) and partition basis. Please note that submitting a
large number of jobs (especially very short ones) can impact the overall
scheduler response for all users.

Specified using -p option in batch script. For example:

::

   #SBATCH -p gpu

`Back to Top <#top>`__

.. raw:: html

   <hr>

Slurm Commands: 
~~~~~~~~~~~~~~~~

Here are a few key Slurm commands. For more information, run the
``man slurm`` or see this page:

-  To Submit jobs using the ``sbatch`` command:

::

   $ sbatch Localscratch-slurm.sb 
   Submitted batch job 8718049

-  To check job status using the squeue command:

::

   $ squeue -u $USER
                JOBID PARTITION     NAME     USER      ST       TIME  NODES  NODELIST(REASON)
              8718049   compute       localscr mahidhar   PD       0:00       1               (Priority)

-  Once the job is running, you will see the job status change:

::

   $ squeue -u $USER
                JOBID PARTITION     NAME     USER    ST       TIME  NODES  NODELIST(REASON)
              8718064     debug        localscr mahidhar   R         0:02      1           expanse-14-01

-  To cancel a job, use the ``scancel`` along with the ``JOBID``:

   -  $scancel

Command Line Jobs 
~~~~~~~~~~~~~~~~~~

::

   The login nodes are meant for compilation, file editing, simple data analysis, and other tasks that use minimal compute resources. <em>Do not run parallel or large jobs on the login nodes - even for simple tests</em>. Even if you could run a simple test on the command line on the login node, full tests should not be run on the login node because the performance will be adversely impacted by all the other tasks and login activities of the other users who are logged onto the same node. For example, at the moment that this note was written,  a `gzip` process was consuming 98% of the CPU time:
   ```
   [mthomas@expanse-ln3 OPENMP]$ top
   ...
     PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                      
   19937 XXXXX     20   0  4304  680  300 R 98.2  0.0   0:19.45 gzip
   ```

Commands that you type into the terminal and run on the sytem are
considered *jobs* and they consume resources. Computationally intensive
jobs should be run only on the compute nodes and not the login nodes.

`Back to Top <#top>`__

.. raw:: html

   <hr>

Hands-on Examples
-----------------

-  `Compiling and Running GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__

   -  `GPU Hello World (GPU) <#hello-world-gpu>`__
   -  `GPU Enumeration <#enum-gpu>`__
   -  `CUDA Mat-Mult <#mat-mul-gpu>`__

-  `Compiling and Running CPU Jobs <#comp-and-run-cpu-jobs>`__

   -  `Hello World (MPI) <#hello-world-mpi>`__
   -  `Hello World (OpenMPI) <#hello-world-omp>`__
   -  `Compiling and Running Hybrid (MPI + OpenMP)
      Jobs <#hybrid-mpi-omp>`__

Compiling and Running GPU/CUDA Jobs
-----------------------------------

Sections: \* `GPU Hello World (GPU) <#hello-world-gpu>`__ \* `GPU
Enumeration <#enum-gpu>`__ \* `CUDA Mat-Mult <#mat-mul-gpu>`__

Note: Expanse provides both NVIDIA K80 and P100 GPU-based resources.
These GPU nodes are allocated as separate resources. Make sure you have
enough allocations and that you are using the right account. For more
details and current information about the Expanse GPU nodes, see the
`Expanse User
Guide <https://www.sdsc.edu/support/user_guides/expanse.html#gpu>`__.

 Expanse GPU Hardware:

In order to compile the CUDA code, you need to load the CUDA module and verify
------------------------------------------------------------------------------

that you have access to the CUDA compile command, ``nvcc:``

::

   [mthomas@expanse-ln3:~/expanse101] module list
   Currently Loaded Modulefiles:
     1) intel/2018.1.163    2) mvapich2_ib/2.3.2
   [mthomas@expanse-ln3:~/expanse101] module purge
   [mthomas@expanse-ln3:~/expanse101] module load cuda
   [mthomas@expanse-ln3:~/expanse101] module list
   Currently Loaded Modulefiles:
     1) cuda/10.1
     [mthomas@expanse-ln3:~/expanse101] which nvcc
     /usr/local/cuda-10.1/bin/nvcc

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU/CUDA Example: Hello World
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsections: \* `GPU Hello World:
Compiling <#hello-world-gpu-compile>`__ \* `GPU Hello World: Batch
Script Submission <#hello-world-gpu-batch-submit>`__ \* `GPU Hello
World: Batch Job Output <#hello-world-gpu-batch-output>`__

GPU Hello World: Compiling
^^^^^^^^^^^^^^^^^^^^^^^^^^

Simple hello runs a cuda command to get the device count on the node
that job is assigned to. :

::

   [mthomas@expanse-ln3:~/expanse101] cd CUDA/hello_cuda
   [mthomas@expanse-ln3:~/expanse101/CUDA/hello_cuda] ll
   total 30
   drwxr-xr-x 2 mthomas use300   4 Apr 16 01:59 .
   drwxr-xr-x 4 mthomas use300  11 Apr 16 01:57 ..
   -rw-r--r-- 1 mthomas use300 313 Apr 16 01:59 hello_cuda.cu
   -rw-r--r-- 1 mthomas use300 269 Apr 16 01:58 hello_cuda.sb
   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]  cat hello_cuda.cu
   /*
    * hello_cuda.cu
    * Copyright 1993-2010 NVIDIA Corporation.
    *    All right reserved
    */
    #include <stdio.h>
    #include <stdlib.h>
    int main( void )
    {
       int deviceCount;
       cudaGetDeviceCount( &deviceCount );
       printf("Hello, Webinar Participants! You have %d devices\n", deviceCount );
       return 0;
    }

-  Compile using the ``nvcc``\  command:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]  nvcc -o hello_cuda hello_cuda.cu
   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]  ll hello_cuda
   -rwxr-xr-x 1 user use300 517437 Apr 10 19:35 hello_cuda
   -rw-r--r-- 1 user use300    304 Apr 10 19:35 hello_cuda.cu
   [expanse-ln2:~/cuda/hello_cuda]

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU Hello World: Batch Script Submit
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  GPU jobs can be run via the slurm scheduler, or on interactive nodes.
-  The slurm scheduler batch script is shown below:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]  cat hello_cuda.sb
   #!/bin/bash
   #SBATCH --job-name="hello_cuda"
   #SBATCH --output="hello_cuda.%j.%N.out"
   #SBATCH --partition=gpu-shared
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=12
   #SBATCH --gres=gpu:2
   #SBATCH -t 01:00:00

   # Define the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib
   #Load the cuda module
   module load cuda

   #Run the job
   ./hello_cuda

-  Some of the batch script variables are described below. For more
   details see the Expanse user guide.
-  GPU nodes can be accessed via either the “gpu” or the “gpu-shared”
   partitions:

::

   #SBATCH -p gpu           

or

::

   #SBATCH -p gpu-shared

In addition to the partition name (required), the type of gpu (optional)
and  the individual GPUs are scheduled as a resource.

::

   #SBATCH --gres=gpu[:type]:n

GPUs will be allocated on a first available, first schedule basis,
unless specified with the [type] option, where type can be \ ``k80``\ 
or \ ``p100``\  Note: type is case sensitive.

::

   #SBATCH --gres=gpu:4     #first available gpu node
   #SBATCH --gres=gpu:k80:4 #only k80 nodes
   #SBATCH --gres=gpu:p100:4 #only p100 nodes

Submit the job

To run the job, type the batch script submission command:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]  sbatch hello_cuda.sb
   Submitted batch job 32663172
   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]

Monitor the job until it is finished:

::

   [user@expanse-ln2:~/cuda/hello_cuda] squeue -u mthomas
   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello] sbatch hello_cuda.sb
   Submitted batch job 32663081
   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello] squeue -u mthomas
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32663081 gpu-share hello_cu  mthomas PD       0:00      1 (Resources)

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU Hello World: Batch Job Output
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello] cat hello_cuda.32663172.expanse-30-04.out

   Hello, Webinar Participants! You have 2 devices

   [mthomas@expanse-ln3:~/expanse101/CUDA/cuda_hello]

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU/CUDA Example: Enumeration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sections: \* `GPU Enumeration: Compiling <#enum-gpu-compile>`__ \* `GPU
Enumeration: Batch Script Submission <#enum-gpu-batch-submit>`__ \* `GPU
Enumeration: Batch Job Output <#enum-gpu-batch-output>`__

.. raw:: html

   <hr>

GPU Enumeration: Compiling
^^^^^^^^^^^^^^^^^^^^^^^^^^

GPU Enumeration Code: This code accesses the cudaDeviceProp object and
returns information about the devices on the node. The list below is
only some of the information that you can look for. The property values
can be used to dynamically allocate or distribute your compute threads
accross the GPU hardware in response to the GPU type.

::

   [user@expanse-ln2:~/cuda/gpu_enum] cat gpu_enum.cu
   #include <stdio.h>

   int main( void ) {
      cudaDeviceProp prop;
      int count;
      printf( " --- Obtaining General Information for CUDA devices  ---\n" );
      cudaGetDeviceCount( &count ) ;
      for (int i=0; i< count; i++) {
         cudaGetDeviceProperties( &prop, i ) ;
         printf( " --- General Information for device %d ---\n", i );
         printf( "Name: %s\n", prop.name );

         printf( "Compute capability: %d.%d\n", prop.major, prop.minor );
         printf( "Clock rate: %d\n", prop.clockRate );
         printf( "Device copy overlap: " );

         if (prop.deviceOverlap)
          printf( "Enabled\n" );
         else
          printf( "Disabled\n");

         printf( "Kernel execution timeout : " );

         if (prop.kernelExecTimeoutEnabled)
            printf( "Enabled\n" );
         else
            printf( "Disabled\n" );

         printf( " --- Memory Information for device %d ---\n", i );
         printf( "Total global mem: %ld\n", prop.totalGlobalMem );
         printf( "Total constant Mem: %ld\n", prop.totalConstMem );
         printf( "Max mem pitch: %ld\n", prop.memPitch );
         printf( "Texture Alignment: %ld\n", prop.textureAlignment );
         printf( " --- MP Information for device %d ---\n", i );
         printf( "Multiprocessor count: %d\n", prop.multiProcessorCount );
         printf( "Shared mem per mp: %ld\n", prop.sharedMemPerBlock );
         printf( "Registers per mp: %d\n", prop.regsPerBlock );
         printf( "Threads in warp: %d\n", prop.warpSize );
         printf( "Max threads per block: %d\n", prop.maxThreadsPerBlock );
         printf( "Max thread dimensions: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2] );
         printf( "Max grid dimensions: (%d, %d, %d)\n", prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2] );
         printf( "\n" );
      }
   }

To compile: check your environment and use the CUDA \ ``nvcc``\ 
command:

::

   [expanse-ln2:~/cuda/gpu_enum] module purge
   [expanse-ln2:~/cuda/gpu_enum] which nvcc
   /usr/bin/which: no nvcc in (/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/user/bin)
   [expanse-ln2:~/cuda/gpu_enum] module load cuda
   [expanse-ln2:~/cuda/gpu_enum] which nvcc
   /usr/local/cuda-7.0/bin/nvcc
   [expanse-ln2:~/cuda/gpu_enum] nvcc -o gpu_enum -I.  gpu_enum.cu
   [expanse-ln2:~/cuda/gpu_enum] ll gpu_enum
   -rwxr-xr-x 1 user use300 517632 Apr 10 18:39 gpu_enum
   [expanse-ln2:~/cuda/gpu_enum]

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU Enumeration: Batch Script Submission
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Contents of the Slurm script Script is asking for 1 GPU.

::

   [expanse-ln2: ~/cuda/gpu_enum] cat gpu_enum.sb
   #!/bin/bash
   #SBATCH --job-name="gpu_enum"
   #SBATCH --output="gpu_enum.%j.%N.out"
   #SBATCH --partition=gpu-shared          # define GPU partition
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=6
   #SBATCH --gres=gpu:1         # define type of GPU
   #SBATCH -t 00:05:00

   # Define the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib
   #Load the cuda module
   module load cuda

   #Run the job
   ./gpu_enum

Submit the job \* To run the job, type the batch script submission
command:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/gpu_enum] sbatch hello_cuda.sb
   Submitted batch job 32663364

Monitor the job \* You can monitor the job until it is finished using
the ``sqeue`` command:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/gpu_enum] squeue -u mthomas
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32663364 gpu-share gpu_enum  mthomas PD       0:00      1 (Resources)

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU Enumeration: Batch Job Output
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Output from script is for multiple devices, which is what was
   specified in script.

::

   [user@expanse-ln2:~/cuda/gpu_enum] cat gpu_enum.22527745.expanse-31-10.out
    --- Obtaining General Information for CUDA devices  ---
    --- General Information for device 0 ---
    --- Obtaining General Information for CUDA devices  ---
    --- General Information for device 0 ---
   Name: Tesla P100-PCIE-16GB
   Compute capability: 6.0
   Clock rate: 1328500
   Device copy overlap: Enabled
   Kernel execution timeout : Disabled
    --- Memory Information for device 0 ---
   Total global mem: 17071734784
   Total constant Mem: 65536
   Max mem pitch: 2147483647
   Texture Alignment: 512
    --- MP Information for device 0 ---
   Multiprocessor count: 56
   Shared mem per mp: 49152
   Registers per mp: 65536
   Threads in warp: 32
   Max threads per block: 1024
   Max thread dimensions: (1024, 1024, 64)
   Max grid dimensions: (2147483647, 65535, 65535)

-  If we change the batch script to ask for 2 devices (see line 8):

::

    1 #!/bin/bash
     2 #SBATCH --job-name="gpu_enum"
     3 #SBATCH --output="gpu_enum.%j.%N.out"
     4 #SBATCH --partition=gpu-shared          # define GPU partition
     5 #SBATCH --nodes=1
     6 #SBATCH --ntasks-per-node=6
     7 ####SBATCH --gres=gpu:1         # define type of GPU
     8 #SBATCH --gres=gpu:2         # first available
     9 #SBATCH -t 00:05:00
    10
    11 # Define the user environment
    12 source /etc/profile.d/modules.sh
    13 module purge
    14 module load intel
    15 module load mvapich2_ib
    16 #Load the cuda module
    17 module load cuda
    18
    19 #Run the job
    20 ./gpu_enum

The output will show information for two devices:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/gpu_enum] sbatch gpu_enum.sb
   !Submitted batch job 32663404
   [mthomas@expanse-ln3:~/expanse101/CUDA/gpu_enum] squeue -u mthomas
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32663404 gpu-share gpu_enum  mthomas CG       0:02      1 expanse-33-03
             [mthomas@expanse-ln3:~/expanse101/CUDA/gpu_enum] cat gpu_enumX.32663404.expanse-33-03.out
              --- Obtaining General Information for CUDA devices  ---
              --- General Information for device 0 ---
             Name: Tesla P100-PCIE-16GB
             Compute capability: 6.0
             Clock rate: 1328500
             Device copy overlap: Enabled
             Kernel execution timeout : Disabled
              --- Memory Information for device 0 ---
             Total global mem: 17071734784
             Total constant Mem: 65536
             Max mem pitch: 2147483647
             Texture Alignment: 512
              --- MP Information for device 0 ---
             Multiprocessor count: 56
             Shared mem per mp: 49152
             Registers per mp: 65536
             Threads in warp: 32
             Max threads per block: 1024
             Max thread dimensions: (1024, 1024, 64)
             Max grid dimensions: (2147483647, 65535, 65535)

              --- General Information for device 1 ---
             Name: Tesla P100-PCIE-16GB
             Compute capability: 6.0
             Clock rate: 1328500
             Device copy overlap: Enabled
             Kernel execution timeout : Disabled
              --- Memory Information for device 1 ---
             Total global mem: 17071734784
             Total constant Mem: 65536
             Max mem pitch: 2147483647
             Texture Alignment: 512
              --- MP Information for device 1 ---
             Multiprocessor count: 56
             Shared mem per mp: 49152
             Registers per mp: 65536
             Threads in warp: 32
             Max threads per block: 1024
             Max thread dimensions: (1024, 1024, 64)
             Max grid dimensions: (2147483647, 65535, 65535)

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

GPU/CUDA Example: Matrix-Multiplication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsections: \* `Matrix Mult. (GPU): Compiling <#mat-mul-gpu-compile>`__
\* `Matrix Mult. (GPU): Batch Script
Submission <#mat-mul-gpu-batch-submit>`__ \* `Matrix Mult. (GPU): Batch
Job Output <#mat-mul-gpu-batch-output>`__

CUDA Example: Matrix-Multiplication
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Change to the CUDA Matrix-Multiplication example directory:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/matmul] ll
   total 454
   drwxr-xr-x 2 mthomas use300     11 Apr 16 02:59 .
   drwxr-xr-x 5 mthomas use300      5 Apr 16 02:37 ..
   -rw-r--r-- 1 mthomas use300    253 Apr 16 01:56 cuda_matmul.sb
   -rw-r--r-- 1 mthomas use300   5106 Apr 16 01:46 exception.h
   -rw-r--r-- 1 mthomas use300   1168 Apr 16 01:46 helper_functions.h
   -rw-r--r-- 1 mthomas use300  29011 Apr 16 01:46 helper_image.h
   -rw-r--r-- 1 mthomas use300  23960 Apr 16 01:46 helper_string.h
   -rw-r--r-- 1 mthomas use300  15414 Apr 16 01:46 helper_timer.h
   -rwxr-xr-x 1 mthomas use300 652768 Apr 16 01:46 matmul
   -rw-r--r-- 1 mthomas use300  13482 Apr 16 02:36 matmul.cu
   -rw-r--r-- 1 mthomas use300    370 Apr 16 02:59 matmul.sb

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

Compiling CUDA Example (GPU)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 Compile the code:

::

   [user@expanse-ln2 CUDA]$ nvcc -o matmul -I.  matrixMul.cu
   [user@expanse-ln2 CUDA]$ ll
   total 172
   drwxr-xr-x  2 user user300     13 Aug  6 00:53 .
   drwxr-xr-x 16 user user300     16 Aug  5 19:02 ..
   -rw-r--r--  1 user user300    458 Aug  6 00:35 CUDA.18347152.expanse-33-02.out
   -rw-r--r--  1 user user300    458 Aug  6 00:37 CUDA.18347157.expanse-33-02.out
   -rw-r--r--  1 user user300    446 Aug  5 19:02 CUDA.8718375.expanse-30-08.out
   -rw-r--r--  1 user user300    253 Aug  5 19:02 cuda.sb
   -rw-r--r--  1 user user300   5106 Aug  5 19:02 exception.h
   -rw-r--r--  1 user user300   1168 Aug  5 19:02 helper_functions.h
   -rw-r--r--  1 user user300  29011 Aug  5 19:02 helper_image.h
   -rw-r--r--  1 user user300  23960 Aug  5 19:02 helper_string.h
   -rw-r--r--  1 user user300  15414 Aug  5 19:02 helper_timer.h
   -rwxr-xr-x  1 user user300 533168 Aug  6 00:53 matmul
   -rw-r--r--  1 user user300  13482 Aug  6 00:50 matrixMul.cu

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

Matrix Mult. (GPU): Batch Script Submission
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Contents of the slurm script:

::

   [user@expanse-ln2 CUDA]$ cat cuda.sb
   #!/bin/bash
   #SBATCH --job-name="matmul"
   #SBATCH --output="matmul.%j.%N.out"
   #SBATCH --partition=gpu-shared
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=6
   #SBATCH --gres=gpu:1
   #SBATCH -t 00:10:00

   # Define the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib
   #Load the cuda module
   module load cuda

   #Run the job
   ./matmul

 Submit the job:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/matmul] sbatch matmul.sb
   Submitted batch job 32663647

Monitor the job:

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/matmul] squeue -u mthomas
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32663647 gpu-share   matmul  mthomas PD       0:00      1 (Resources)
   [mthomas@expanse-ln3:~/expanse101/CUDA/matmul]

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

Matrix Mult. (GPU): Batch Job Output
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   [mthomas@expanse-ln3:~/expanse101/CUDA/matmul] cat matmul.32663647.expanse-33-03.out
   [Matrix Multiply Using CUDA] - Starting...
   GPU Device 0: "Tesla P100-PCIE-16GB" with compute capability 6.0

   MatrixA(320,320), MatrixB(640,320)
   Computing result using CUDA Kernel...
   done
   Performance= 1676.99 GFlop/s, Time= 0.078 msec, Size= 131072000 Ops, WorkgroupSize= 1024 threads/block
   Checking computed result for correctness: Result = PASS

   NOTE: The CUDA Samples are not meant for performance measurements. Results may
   vary when GPU Boost is enabled.

`Back to GPU/CUDA Jobs <#comp-and-run-cuda-jobs>`__ `Back to
Top <#top>`__

.. raw:: html

   <hr>

Compiling and Running CPU Jobs: 
--------------------------------

Sections: \* `Hello World (MPI) <#hello-world-mpi>`__ \* `Hello World
(OpenMP) <#hello-world-omp>`__ \* `Running Hybrid (MPI + OpenMP)
Jobs <#hybrid-mpi-omp>`__

Hello World (MPI)
~~~~~~~~~~~~~~~~~

Subsections: \* `Hello World (MPI): Source
Code <#hello-world-mpi-source>`__ \* `Hello World (MPI):
Compiling <#hello-world-mpi-compile>`__ \* `Hello World (MPI):
Interactive Jobs <#hello-world-mpi-interactive>`__ \* `Hello World
(MPI): Batch Script Submission <#hello-world-mpi-batch-submit>`__ \*
`Hello World (MPI): Batch Script
Output <#hello-world-mpi-batch-output>`__

CPU Hello World: Source code: <#hello-world-mpi-source>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Change to the MPI examples directory (assuming you already copied the ):

::

   [mthomas@expanse-ln3 expanse101]$ cd MPI
   [mthomas@expanse-ln3 MPI]$ ll
   [mthomas@expanse-ln3:~/expanse101/MPI] ll
   total 498
   drwxr-xr-x 4 mthomas use300      7 Apr 16 01:11 .
   drwxr-xr-x 6 mthomas use300      6 Apr 15 20:10 ..
   -rw-r--r-- 1 mthomas use300    336 Apr 15 15:47 hello_mpi.f90
   drwxr-xr-x 2 mthomas use300      3 Apr 16 01:02 IBRUN
   drwxr-xr-x 2 mthomas use300      3 Apr 16 00:57 MPIRUN_RSH
   ``
   [mthomas@expanse-ln3 OPENMP]$cat hello_mpi.f90
   !  Fortran example  
      program hello
      include 'mpif.h'
      integer rank, size, ierror, tag, status(MPI_STATUS_SIZE)

      call MPI_INIT(ierror)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
      print*, 'node', rank, ': Hello and Welcome to Webinar Participants!'
      call MPI_FINALIZE(ierror)
      end

Compile the code:

::

   [mthomas@expanse-ln3 MPI]$ mpif90 -o hello_mpi hello_mpi.f90
   [mthomas@expanse-ln3:~/expanse101/MPI] ll
   total 498
   drwxr-xr-x 4 mthomas use300      7 Apr 16 01:11 .
   drwxr-xr-x 6 mthomas use300      6 Apr 15 20:10 ..
   -rw-r--r-- 1 mthomas use300     77 Apr 16 01:08 compile.txt
   -rwxr-xr-x 1 mthomas use300 750288 Apr 16 01:11 hello_mpi
   -rw-r--r-- 1 mthomas use300    336 Apr 15 15:47 hello_mpi.f90
   drwxr-xr-x 2 mthomas use300      3 Apr 16 01:02 IBRUN
   drwxr-xr-x 2 mthomas use300      3 Apr 16 00:57 MPIRUN_RSH

Note: The two directories that contain batch scripts needed to run the
jobs using the parallel/slurm environment.

-  First, we should verify that the user environment is correct for
   running the examples we will work with in this tutorial.

::

   [mthomas@expanse-ln3 MPI]$ module list
   Currently Loaded Modulefiles:
   1) intel/2018.1.163    2) mvapich2_ib/2.3.2

-  If you have trouble with your modules, you can remove the existing
   environment (purge) and then reload them. After purging, the PATH
   variable has fewer path directories available:

::

   [mthomas@expanse-ln3:~] module purge
   [mthomas@expanse-ln3:~] echo $PATH
   /home/mthomas/miniconda3/bin:/home/mthomas/miniconda3/condabin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/mthomas/bin

-  Next, you reload the modules that you need:

::

   [mthomas@expanse-ln3 ~]$ module load intel
   [mthomas@expanse-ln3 ~]$ module load mvapich2_ib

-  You will see that there are more binaries in the PATH:

::

   [mthomas@expanse-ln3:~] echo $PATH
   /opt/mvapich2/intel/ib/bin:/opt/intel/2018.1.163/compilers_and_libraries_2018.1.163/linux/bin/intel64:/home/mthomas/miniconda3/bin:/home/mthomas/miniconda3/condabin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/opt/ibutils/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/home/mthomas/bin

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (MPI): Compiling: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Compile the MPI hello world code.
-  For this, we use the command ``mpif90``, which is loaded into your
   environment when you loaded the intel module above.
-  To see where the command is located, use the ``which`` command:

::

   [mthomas@expanse-ln3 MPI]$ which mpif90
   /opt/mvapich2/intel/ib/bin/mpif90

-  Compile the code:

::

   mpif90 -o hello_mpi hello_mpi.f90

-  Verify that the executable has been created:

::

   [mthomas@expanse-ln3:~/expanse101/MPI] ll
   total 498
   drwxr-xr-x 4 mthomas use300      7 Apr 16 01:11 .
   drwxr-xr-x 6 mthomas use300      6 Apr 15 20:10 ..
   -rwxr-xr-x 1 mthomas use300 750288 Apr 16 01:11 hello_mpi
   -rw-r--r-- 1 mthomas use300    336 Apr 15 15:47 hello_mpi.f90
   drwxr-xr-x 2 mthomas use300      3 Apr 16 01:02 IBRUN
   drwxr-xr-x 2 mthomas use300      3 Apr 16 00:57 MPIRUN_RSH

-  In the next sections, we will see how to run parallel code using two
   environments:

   -  Running a parallel job on an *Interactive* compute node
   -  Running parallel code using the batch queue system

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (MPI): Interactive Jobs: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  To run MPI (or other executables) from the command line, you need to
   use the “Interactive” nodes.
-  To launch the nodes (to get allocated a set of nodes), use the
   ``srun`` command. This example will request one node, all 24 cores,
   in the debug partition for 30 minutes:

::

   [mthomas@expanse-ln3:~/expanse101/MPI] date
   Thu Apr 16 01:21:48 PDT 2020
   [mthomas@expanse-ln3:~/expanse101/MPI] srun --pty --nodes=1 --ntasks-per-node=24 -p debug -t 00:30:00 --wait 0 /bin/bash
   [mthomas@expanse-14-01:~/expanse101/MPI] date
   Thu Apr 16 01:22:42 PDT 2020
   [mthomas@expanse-14-01:~/expanse101/MPI] hostname
   expanse-14-01.sdsc.edu

-  Note:

   -  You will know when you have an interactive node because the srun
      command will return and you will be on a different host.
   -  Note: If the cluster is very busy, it may take some time to obtain
      the nodes.

-  Once you have the interactive session, your MPI code will be allowed
   to execute on the command line.

::

   [mthomas@expanse-14-01 MPI]$ mpirun -np 4 ./hello_mpi
    node           0 : Hello and Welcome to Webinar Participants!
    node           1 : Hello and Welcome to Webinar Participants!
    node           2 : Hello and Welcome to Webinar Participants!
    node           3 : Hello and Welcome to Webinar Participants!
   [mthomas@expanse-14-01 MPI]$

When you are done testing code, exit the Interactive session.

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (MPI): Batch Script Submission: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To submit jobs to the Slurm queuing system, you need to create a slurm
batch job script and submit it to the queuing system.

-  Change directories to the IBRUN directory using the
   ``hellompi-slurm.sb`` batch script:

::

   [mthomas@expanse-ln3 MPI]$ cd IBRUN/
   [mthomas@expanse-ln3 IBRUN]$ cat hellompi-slurm.sb
   #!/bin/bash
   #SBATCH --job-name="hellompi"
   #SBATCH --output="hellompi.%j.%N.out"
   #SBATCH --partition=compute
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=24
   #SBATCH --export=ALL
   #SBATCH -t 00:30:00

   # load the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib

   #This job runs with 2 nodes, 24 cores per node for a total of 48 cores.
   #ibrun in verbose mode will give binding detail

   ibrun -v ../hello_mpi

-  to run the job, use the command below:

::

   [mthomas@expanse-ln3 IBRUN]$ sbatch hellompi.sb
   Submitted batch job 32662205

-  In some cases, you may have access to a reservation queue, use the
   command below:

::

   sbatch --res=SI2018DAY1 hellompi-slurm.sb

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (MPI): Batch Script Output: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Check job status using the ``squeue`` command.

::

   [mthomas@expanse-ln3 IBRUN]$ sbatch hellompi-slurm.sb; squeue -u username
   Submitted batch job 18345138
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32662205   compute hellompi  username PD       0:00      2 (None)
   ....

   [mthomas@expanse-ln3 IBRUN]$ squeue -u username
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32662205   compute hellompi  username  R       0:07      2 expanse-21-[47,57]
   [mthomas@expanse-ln3 IBRUN]$ squeue -u username
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             32662205   compute hellompi  username CG       0:08      2 expanse-21-[47,57]

::

   * Note: You will see the `ST` column information change when the job status changes: new jobs go into  `SP` (pending); after some time it moves to  `R` (running): when completed, the state changes to `CG` (completed)
   * the JOBID is the job identifer and can be used to track or cancel the job. It is also used as part of the output file name.

-  Look at the directory for and output file with the job id as part of
   the name:

::

   [mthomas@expanse-ln3 IBRUN]$
   total 48
   drwxr-xr-x 2 mthomas use300    4 Apr 16 01:31 .
   drwxr-xr-x 4 mthomas use300    7 Apr 16 01:11 ..
   -rw-r--r-- 1 mthomas use300 2873 Apr 16 01:31 hellompi.32662205.expanse-20-03.out
   -rw-r--r-- 1 mthomas use300  341 Apr 16 01:30 hellompi-slurm.sb

-  To see the contents of the output file, use the ``cat`` command:

::

   [mthomas@expanse-ln3 IBRUN]$ cat hellompi.32662205.expanse-20-03.out
   IBRUN: Command is ../hello_mpi
   IBRUN: Command is /home/username/expanse-examples/expanse101/MPI/hello_mpi
   IBRUN: no hostfile mod needed
   IBRUN: Nodefile is /tmp/0p4Nbx12u1

   IBRUN: MPI binding policy: compact/core for 1 threads per rank (12 cores per socket)
   IBRUN: Adding MV2_USE_OLD_BCAST=1 to the environment
   IBRUN: Adding MV2_CPU_BINDING_LEVEL=core to the environment
   IBRUN: Adding MV2_ENABLE_AFFINITY=1 to the environment
   IBRUN: Adding MV2_DEFAULT_TIME_OUT=23 to the environment
   IBRUN: Adding MV2_CPU_BINDING_POLICY=bunch to the environment
   IBRUN: Adding MV2_USE_HUGEPAGES=0 to the environment
   IBRUN: Adding MV2_HOMOGENEOUS_CLUSTER=0 to the environment
   IBRUN: Adding MV2_USE_UD_HYBRID=0 to the environment
   IBRUN: Added 8 new environment variables to the execution environment
   IBRUN: Command string is [mpirun_rsh -np 48 -hostfile /tmp/0p4Nbx12u1 -export-all /home/username/expanse-examples/expanse101/MPI/hello_mpi]
    node          18 : Hello and Welcome to Webinar Participants!
    node          17 : Hello and Welcome to Webinar Participants!
    node          20 : Hello and Welcome to Webinar Participants!
    node          21 : Hello and Welcome to Webinar Participants!
    node          22 : Hello and Welcome to Webinar Participants!
    node           5 : Hello and Welcome to Webinar Participants!
    node           3 : Hello and Welcome to Webinar Participants!
    node           6 : Hello and Welcome to Webinar Participants!
    node          16 : Hello and Welcome to Webinar Participants!
    node          19 : Hello and Welcome to Webinar Participants!
    node          14 : Hello and Welcome to Webinar Participants!
    node          10 : Hello and Welcome to Webinar Participants!
    node          13 : Hello and Welcome to Webinar Participants!
    node          15 : Hello and Welcome to Webinar Participants!
    node           9 : Hello and Welcome to Webinar Participants!
    node          12 : Hello and Welcome to Webinar Participants!
    node           4 : Hello and Welcome to Webinar Participants!
    node          23 : Hello and Welcome to Webinar Participants!
    node           7 : Hello and Welcome to Webinar Participants!
    node          11 : Hello and Welcome to Webinar Participants!
    node           8 : Hello and Welcome to Webinar Participants!
    node           1 : Hello and Welcome to Webinar Participants!
    node           2 : Hello and Welcome to Webinar Participants!
    node           0 : Hello and Welcome to Webinar Participants!
    node          39 : Hello and Welcome to Webinar Participants!
    node          38 : Hello and Welcome to Webinar Participants!
    node          47 : Hello and Welcome to Webinar Participants!
    node          45 : Hello and Welcome to Webinar Participants!
    node          42 : Hello and Welcome to Webinar Participants!
    node          35 : Hello and Welcome to Webinar Participants!
    node          28 : Hello and Welcome to Webinar Participants!
    node          32 : Hello and Welcome to Webinar Participants!
    node          40 : Hello and Welcome to Webinar Participants!
    node          44 : Hello and Welcome to Webinar Participants!
    node          41 : Hello and Welcome to Webinar Participants!
    node          30 : Hello and Welcome to Webinar Participants!
    node          31 : Hello and Welcome to Webinar Participants!
    node          29 : Hello and Welcome to Webinar Participants!
    node          37 : Hello and Welcome to Webinar Participants!
    node          43 : Hello and Welcome to Webinar Participants!
    node          46 : Hello and Welcome to Webinar Participants!
    node          34 : Hello and Welcome to Webinar Participants!
    node          26 : Hello and Welcome to Webinar Participants!
    node          24 : Hello and Welcome to Webinar Participants!
    node          27 : Hello and Welcome to Webinar Participants!
    node          25 : Hello and Welcome to Webinar Participants!
    node          33 : Hello and Welcome to Webinar Participants!
    node          36 : Hello and Welcome to Webinar Participants!
   IBRUN: Job ended with value 0
   [mthomas@expanse-ln3 IBRUN]$

-  Note the order in which the output was written into the output file.
   There is an entry for each of the 48 cores (2 nodes, 24 cores/node),
   but the output is not ordered. This is typical because the time for
   each core to start and finish its work is asynchronous.

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (OpenMP): 
~~~~~~~~~~~~~~~~~~~~~~

Subsections: \* `Hello World (OpenMP): Source
Code <#hello-world-omp-source>`__ \* `Hello World (OpenMP):
Compiling <#hello-world-omp-compile>`__ \* `Hello World (OpenMP): Batch
Script Submission <#hello-world-omp-batch-submit>`__ \* `Hello World
(OpenMP): Batch Script Output <#hello-world-omp-batch-output>`__

Hello World (OpenMP): Source Code 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Change to the OPENMP examples directory:

::

   [mthomas@expanse-ln3 expanse101]$ cd OPENMP/
   [mthomas@expanse-ln3 OPENMP]$ ls -al
   total 479
   drwxr-xr-x  2 username use300      6 Aug  5 22:19 .
   drwxr-xr-x 16 username use300     16 Aug  5 19:02 ..
   -rwxr-xr-x  1 username use300 728112 Aug  5 19:02 hello_openmp
   -rw-r--r--  1 username use300    267 Aug  5 22:19 hello_openmp.f90
   -rw-r--r--  1 username use300    310 Aug  5 19:02 openmp-slurm.sb
   -rw-r--r--  1 username use300    347 Aug  5 19:02 openmp-slurm-shared.sb

   [mthomas@expanse-ln3 OPENMP]$ cat hello_openmp.f90
         PROGRAM OMPHELLO
         INTEGER TNUMBER
         INTEGER OMP_GET_THREAD_NUM

   !$OMP PARALLEL DEFAULT(PRIVATE)
         TNUMBER = OMP_GET_THREAD_NUM()
         PRINT *, 'Hello from Thread Number[',TNUMBER,'] and Welcome Webinar!'
   !$OMP END PARALLEL

         STOP
         END

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (OpenMP): Compiling: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Note that there is already a compiled version of the
``hello_openmp.f90`` code. You can save or delete this version.

-  In this example, we compile the source code using the ``ifort``
   command, and verify that it was created:

::

   [mthomas@expanse-ln3 OPENMP]$ ifort -o hello_openmp -qopenmp hello_openmp.f90
   [mthomas@expanse-ln3 OPENMP]$ ls -al
   [mthomas@expanse-ln3:~/expanse101/OPENMP] ll
   total 77
   drwxr-xr-x 2 mthomas use300      7 Apr 16 00:35 .
   drwxr-xr-x 6 mthomas use300      6 Apr 15 20:10 ..
   -rwxr-xr-x 1 mthomas use300 816952 Apr 16 00:35 hello_openmp
   -rw-r--r-- 1 mthomas use300    267 Apr 15 15:47 hello_openmp_2.f90
   -rw-r--r-- 1 mthomas use300    267 Apr 15 15:47 hello_openmp.f90
   -rw-r--r-- 1 mthomas use300    311 Apr 15 15:47 openmp-slurm.sb
   -rw-r--r-- 1 mthomas use300    347 Apr 15 15:47 openmp-slurm-shared.sb

-  Note that if you try to run OpenMP code from the command line, in the
   current environment, the code will run (because it is based on
   Pthreads, which exist on the node):

::

   [mthomas@expanse-ln2 OPENMP]$ ./hello_openmp
   Hello from Thread Number[           8 ] and Welcome HPC Trainees!
   Hello from Thread Number[           3 ] and Welcome HPC Trainees!
   Hello from Thread Number[          16 ] and Welcome HPC Trainees!
   Hello from Thread Number[          12 ] and Welcome HPC Trainees!
   Hello from Thread Number[           9 ] and Welcome HPC Trainees!
   Hello from Thread Number[           5 ] and Welcome HPC Trainees!
   Hello from Thread Number[           4 ] and Welcome HPC Trainees!
   Hello from Thread Number[          14 ] and Welcome HPC Trainees!
   Hello from Thread Number[           7 ] and Welcome HPC Trainees!
   Hello from Thread Number[          11 ] and Welcome HPC Trainees!
   Hello from Thread Number[          13 ] and Welcome HPC Trainees!
   Hello from Thread Number[           6 ] and Welcome HPC Trainees!
   Hello from Thread Number[          10 ] and Welcome HPC Trainees!
   Hello from Thread Number[          19 ] and Welcome HPC Trainees!
   Hello from Thread Number[          15 ] and Welcome HPC Trainees!
   Hello from Thread Number[           2 ] and Welcome HPC Trainees!
   Hello from Thread Number[          18 ] and Welcome HPC Trainees!
   Hello from Thread Number[          17 ] and Welcome HPC Trainees!
   Hello from Thread Number[          23 ] and Welcome HPC Trainees!
   Hello from Thread Number[          20 ] and Welcome HPC Trainees!
   Hello from Thread Number[          22 ] and Welcome HPC Trainees!
   Hello from Thread Number[           1 ] and Welcome HPC Trainees!
   Hello from Thread Number[           0 ] and Welcome HPC Trainees!
   Hello from Thread Number[          21 ] and Welcome HPC Trainees!

-  In the example below, we used the OpenMP feature to set the number of
   threads from the command line.

::

   [mthomas@expanse-ln3 OPENMP]$ export OMP_NUM_THREADS=4; ./hello_openmp
   Hello from Thread Number[           0 ] and Welcome HPC Trainees!
   Hello from Thread Number[           1 ] and Welcome HPC Trainees!
   Hello from Thread Number[           2 ] and Welcome HPC Trainees!
   Hello from Thread Number[           3 ] and Welcome HPC Trainees!

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (OpenMP): Batch Script Submission
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The submit script is openmp-slurm.sb:

::

   [mthomas@expanse-ln2 OPENMP]$ cat openmp-slurm.sb
   #!/bin/bash
   #SBATCH --job-name="hello_openmp"
   #SBATCH --output="hello_openmp.%j.%N.out"
   #SBATCH --partition=compute
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=24
   #SBATCH --export=ALL
   #SBATCH -t 01:30:00

   # Define the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib

   #SET the number of openmp threads
   export OMP_NUM_THREADS=24

   #Run the job using mpirun_rsh
   ./hello_openmp

-  to submit use the sbatch command:

::

   [mthomas@expanse-ln2 OPENMP]$ sbatch openmp-slurm.sb
   Submitted batch job 32661678
   [mthomas@expanse-ln2 OPENMP]$ squeue -u username
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                32661678   compute hello_op  mthomas PD       0:00      1 (Priority)
             ...

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hello World (OpenMP): Batch Script Output: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Once the job is finished:

::

   [mthomas@expanse-ln2 OPENMP] cat hello_openmp.32661678.expanse-07-47.out
    Hello from Thread Number[           5 ] and Welcome HPC Trainees!
    Hello from Thread Number[           7 ] and Welcome HPC Trainees!
    Hello from Thread Number[          16 ] and Welcome HPC Trainees!
    Hello from Thread Number[           9 ] and Welcome HPC Trainees!
    Hello from Thread Number[          18 ] and Welcome HPC Trainees!
    Hello from Thread Number[          12 ] and Welcome HPC Trainees!
    Hello from Thread Number[          10 ] and Welcome HPC Trainees!
    Hello from Thread Number[           0 ] and Welcome HPC Trainees!
    Hello from Thread Number[          14 ] and Welcome HPC Trainees!
    Hello from Thread Number[           4 ] and Welcome HPC Trainees!
    Hello from Thread Number[           3 ] and Welcome HPC Trainees!
    Hello from Thread Number[          11 ] and Welcome HPC Trainees!
    Hello from Thread Number[          19 ] and Welcome HPC Trainees!
    Hello from Thread Number[          22 ] and Welcome HPC Trainees!
    Hello from Thread Number[          15 ] and Welcome HPC Trainees!
    Hello from Thread Number[           2 ] and Welcome HPC Trainees!
    Hello from Thread Number[           6 ] and Welcome HPC Trainees!
    Hello from Thread Number[           1 ] and Welcome HPC Trainees!
    Hello from Thread Number[          21 ] and Welcome HPC Trainees!
    Hello from Thread Number[          20 ] and Welcome HPC Trainees!
    Hello from Thread Number[          17 ] and Welcome HPC Trainees!
    Hello from Thread Number[          23 ] and Welcome HPC Trainees!
    Hello from Thread Number[          13 ] and Welcome HPC Trainees!
    Hello from Thread Number[           8 ] and Welcome HPC Trainees!

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hybrid (MPI + OpenMP) Jobs: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subsections: \* `Hybrid (MPI + OpenMP): Source
Code <#hybrid-mpi-omp-source>`__ \* `Hybrid (MPI + OpenMP):
Compiling <#hybrid-mpi-omp-compile>`__ \* `Hybrid (MPI + OpenMP): Batch
Script Submission <#hybrid-mpi-omp-batch-submit>`__ \* `Hybrid (MPI +
OpenMP): Batch Script Output <#hybrid-mpi-omp-batch-output>`__

Hybrid (MPI + OpenMP) Source Code: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Several HPC codes use a hybrid MPI, OpenMP approach. \* ``ibrun``
wrapper developed to handle such hybrid use cases. Automatically senses
the MPI build (mvapich2, openmpi) and binds tasks correctly. \*
``ibrun -help`` gives detailed usage info. \* hello_hybrid.c is a sample
code, and hello_hybrid.cmd shows “ibrun” usage. \* Change to the HYBRID
examples directory:

::

   [mthomas@expanse-ln2 expanse101]$ cd HYBRID/
   [mthomas@expanse-ln2 HYBRID]$ ll
   total 94
   drwxr-xr-x  2 username use300      5 Aug  5 19:02 .
   drwxr-xr-x 16 username use300     16 Aug  5 19:02 ..
   -rwxr-xr-x  1 username use300 103032 Aug  5 19:02 hello_hybrid
   -rw-r--r--  1 username use300    636 Aug  5 19:02 hello_hybrid.c
   -rw-r--r--  1 username use300    390 Aug  5 19:02 hybrid-slurm.sb

-  Look at the contents of the ``hello_hybrid.c`` file

::

   [mthomas@expanse-ln2 HYBRID]$ cat hello_hybrid.c
   #include <stdio.h>
   #include "mpi.h"
   #include <omp.h>

   int main(int argc, char *argv[]) {
     int numprocs, rank, namelen;
     char processor_name[MPI_MAX_PROCESSOR_NAME];
     int iam = 0, np = 1;

     MPI_Init(&argc, &argv);
     MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
     MPI_Comm_rank(MPI_COMM_WORLD, &rank);
     MPI_Get_processor_name(processor_name, &namelen);

     #pragma omp parallel default(shared) private(iam, np)
     {
       np = omp_get_num_threads();
       iam = omp_get_thread_num();
       printf("Hello Webinar participants from thread %d out of %d from process %d out of %d on %s\n",
              iam, np, rank, numprocs, processor_name);
     }

     MPI_Finalize();
   }

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hybrid (MPI + OpenMP): Compiling: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  To compile the hybrid MPI + OpenMPI code, we need to refer to the
   table of compilers listed above (and listed in the user guide).
-  We will use the command ``mpicx -openmp``

::

   [mthomas@expanse-ln2 HYBRID]$ mpicc -openmp -o hello_hybrid hello_hybrid.c
   [mthomas@expanse-ln2 HYBRID]$ ll
   total 39
   drwxr-xr-x  2 username use300      5 Aug  6 00:12 .
   drwxr-xr-x 16 username use300     16 Aug  5 19:02 ..
   -rwxr-xr-x  1 username use300 103032 Aug  6 00:12 hello_hybrid
   -rw-r--r--  1 username use300    636 Aug  5 19:02 hello_hybrid.c
   -rw-r--r--  1 username use300    390 Aug  5 19:02 hybrid-slurm.sb

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hybrid (MPI + OpenMP): Batch Script Submission: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  To submit the hybrid code, we still use the ``ibrun`` command.
-  In this example, we set the number of threads explicitly.

::

   [mthomas@expanse-ln2 HYBRID]$ cat hybrid-slurm.sb
   #!/bin/bash
   #SBATCH --job-name="hellohybrid"
   #SBATCH --output="hellohybrid.%j.%N.out"
   #SBATCH --partition=compute
   #SBATCH --nodes=2
   #SBATCH --ntasks-per-node=24
   #SBATCH --export=ALL
   #SBATCH -t 01:30:00


   # Define the user environment
   source /etc/profile.d/modules.sh
   module purge
   module load intel
   module load mvapich2_ib

   #This job runs with 2 nodes, 24 cores per node for a total of 48 cores.
   # We use 8 MPI tasks and 6 OpenMP threads per MPI task

   export OMP_NUM_THREADS=6
   ibrun --npernode 4 ./hello_hybrid

-  Submit the job to the Slurm queue, and check the job status

::

   [mthomas@expanse-ln2 HYBRID]$ sbatch hybrid-slurm.sb
   Submitted batch job 18347079
   [mthomas@expanse-ln2 HYBRID]$ squeue -u username
                JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             18347079   compute hellohyb  username  R       0:04      2 expanse-01-[01,04]
   [mthomas@expanse-ln2 HYBRID]$ ll

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>

Hybrid (MPI + OpenMP): Batch Script Output: 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

   [mthomas@expanse-ln2 HYBRID]$ ll
   total 122
   drwxr-xr-x  2 username use300      6 Aug  6 00:12 .
   drwxr-xr-x 16 username use300     16 Aug  5 19:02 ..
   -rwxr-xr-x  1 username use300 103032 Aug  6 00:12 hello_hybrid
   -rw-r--r--  1 username use300   3696 Aug  6 00:12 hellohybrid.18347079.expanse-01-01.out
   -rw-r--r--  1 username use300    636 Aug  5 19:02 hello_hybrid.c
   -rw-r--r--  1 username use300    390 Aug  5 19:02 hybrid-slurm.sb
   [mthomas@expanse-ln2 HYBRID]$ cat hellohybrid.18347079.expanse-01-01.out
   Hello from thread 4 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 3 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 0 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 2 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 1 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 2 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 4 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 0 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 3 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 5 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 3 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 4 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 0 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 2 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 5 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 5 out of 6 from process 3 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 3 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 2 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 0 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 4 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 5 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 1 out of 6 from process 2 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 1 out of 6 from process 1 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 1 out of 6 from process 0 out of 8 on expanse-01-01.sdsc.edu
   Hello from thread 0 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 0 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 2 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 2 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 3 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 5 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 4 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 1 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 4 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 1 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 0 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 5 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 2 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 1 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 3 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 4 out of 6 from process 4 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 0 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 1 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 4 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 2 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 5 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 3 out of 6 from process 6 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 5 out of 6 from process 7 out of 8 on expanse-01-04.sdsc.edu
   Hello from thread 3 out of 6 from process 5 out of 8 on expanse-01-04.sdsc.edu
   [mthomas@expanse-ln2 HYBRID]$

`Back to CPU Jobs <#comp-and-run-cpu-jobs>`__ `Back to Top <#top>`__

.. raw:: html

   <hr>
