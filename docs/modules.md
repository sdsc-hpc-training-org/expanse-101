## <a name="modules"></a>Expanse Environment Modules: Customizing Your User Environment
The Environment Modules package provides for dynamic modification of your shell environment. Module commands set, change, or delete environment variables, typically in support of a particular application. They also let the user choose between different versions of the same software or different combinations of related codes. See:
https://www.sdsc.edu/support/user_guides/expanse.html#modules

<a name="top"> In this Section:
* [Introduction to the Lua Lmod Module System](#module-lmod-intro)
* [Common module commands](#module-commands)
<!----
* [Load and Check Modules and Environment](#load-and-check-module-env)
* [Module Error: command not found](#module-error)
---->

### Introduction to the Lua Lmod Module System<a name="module-lmod-intro"></a>
* Expanse uses Lmod, a Lua based module system.
* See: https://lmod.readthedocs.io/en/latest/010_user.html
* Users setup custom environments by loading available modules into the shell environment, including needed compilers and libraries and the batch scheduler. 
* What’s the same as Comet:
  * Dynamic modification of your shell environment
  * User can set, change, or delete environment variables
  * User chooses between different versions of the same software or different combinations of related codes.
* Modules: What’s Different?
  * Users will need to load the scheduler (e.g. slurm)
  * Users will not see all available modules when they run command "module available" without loading a compiler.
  * Use the command "module spider" option to see if a particular package exists and can be loaded, run command
      * module spider <package>
      * module keywords <term>
  * For additional details, and to identify module dependencies modules, use the command
      * module spider <application_name>
  * The module paths are different for the CPU and GPU nodes. Users can enable the paths by loading the following modules:               
      * module load cpu  (for cpu nodes)
      * module load gpu  (for gpu nodes)  
      * note: avoid loading both modules

### Modules: Popular Lmod Commands<a name="module-commands"></a>


Here are some common module commands and their descriptions:

| Lmod Command | Description |
|:--- | :--- |
|module list|List the modules that are currently loaded|
|module avail|List the modules that are available in environment|
|module spider|List of the modules and extensions currently available|
|module display <module_name>|Show the environment variables used by
<module name> and how they are affected|
|module unload <module name>|Remove <module name> from the environment|
|module load <module name>|Load <module name> into the environment|
|module swap <module one> <module two>|Replace <module one> with
<module two> in the environment|
|module help|get a list of all the commands that module knows about do:

Lmod commands support *short-hand* notation, for example:

* Shorthand notation:   
```
   ml foo == module load foo
   ml -bar”  == module unload bar
```
*SDSC Guidance:   add module calls to your environment and batch scripts*



<b> A few module command examples:</b>

* Default environment: `list`, `li`
```
[mthomas@expanse-ln3:~] module list
Currently Loaded Modulefiles:
1) intel/2018.1.163    2) mvapich2_ib/2.3.2
```
* List available modules:  `available`, `avail`, `av`

```
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
```

[Back to Top](#top)
<hr>

### <a name="load-and-check-module-env"></a>Load and Check Modules and Environment

* Load modules:
```
[mthomas@expanse-ln3:~] module list
Currently Loaded Modulefiles:
1) intel/2018.1.163    2) mvapich2_ib/2.3.2
[mthomas@expanse-ln3:~] module add spark/1.2.0
[mthomas@expanse-ln3:~] module list
Currently Loaded Modulefiles:
1) intel/2018.1.163    3) hadoop/2.6.0
2) mvapich2_ib/2.3.2   4) spark/1.2.0

```

Show loaded module details:
```
$ module show fftw/3.3.4
[mthomas@expanse-ln3:~] module show spark/1.2.0
-------------------------------------------------------------------
/opt/modulefiles/applications/spark/1.2.0:

module-whatis     Spark
module-whatis     Version: 1.2.0
module         load hadoop/2.6.0
prepend-path     PATH /opt/spark/1.2.0/bin
setenv         SPARK_HOME /opt/spark/1.2.0
-------------------------------------------------------------------
```

Once you have loaded the modules, you can check the system variables that are available for you to use.
* To see all variable, run the <b>`env`</b> command. Typically, you will see more than 60 lines containing information such as your login name, shell, your home directory:
```
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
```

To see the value for any of these variables, use the `echo` command:
```
[mthomas@expanse-ln3 IBRUN]$ echo $PATH
PATH=/opt/gnu/gcc/bin:/opt/gnu/bin:/opt/mvapich2/intel/ib/bin:/opt/intel/composer_xe_2013_sp1.2.144/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/mpirt/bin/intel64:/opt/intel/composer_xe_2013_sp1.2.144/debugger/gdb/intel64_mic/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/ibutils/bin:/usr/java/latest/bin:/opt/pdsh/bin:/opt/rocks/bin:/opt/rocks/sbin:/opt/sdsc/bin:/opt/sdsc/sbin:/home/username/bin
```
[Back to Top](#top)
<hr>


### <a name="module-error"></a>Troubleshooting:Module Error

Sometimes this error is encountered when switching from one shell to another or attempting to run the module command from within a shell script or batch job. The module command may not be inherited between the shells.  To keep this from happening, execute the following command:
```
[expanse-ln3:~]source /etc/profile.d/modules.sh
```
OR add this command to your shell script (including Slurm batch scripts)


[Back to Top](#top)
<hr>
