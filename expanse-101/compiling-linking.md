## Compiling & Linking Code

Expanse provides the Intel, Portland Group (PGI), and GNU compilers along with multiple MPI implementations (MVAPICH2, MPICH2, OpenMPI). Most applications will achieve the best performance on Expanse using the Intel compilers and MVAPICH2 and the majority of libraries installed on Expanse have been built using this combination. Having such a diverse set of compilers avaiable allows for our users to customize the software stack need for their application. However, there
can be some complexity involved in sorting out the module dependencies needed for your applications. Often the set of modules being loaded depends on the application you are using and the compiler and libraries you may need. In many cases you will need to use the ```module spider``` command to sort out what modules your application will need. Additionally, it is possible the list will change if some of the dependent software changes.

Other compilers and versions can be installed by Expanse staff on request. For more information, see the [Expanse User Guide.]
(https://www.sdsc.edu/support/user_guides/expanse.html#compiling)
Other compilers and versions can be installed by Expanse staff on request. For more information, see the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#compiling).


### CPU/GPU Compilers
Expanse CPU and GPU nodes have different compiler libraries.

#### CPU Nodes
* GNU, Intel, AOCC (AMD) compilers
* Multiple MPI implementations (OpenMPI, MVAPICH2, and IntelMPI).
* A majority of applications have been built using gcc/10.2.0 which features AMD Rome specific optimization flags (-march=znver2).
* Intel, and AOCC compilers all have flags to support Advanced Vector Extensions 2 (AVX2).

Users should evaluate their application for best compiler and library selection. GNU, Intel, and AOCC compilers all have flags to support Advanced Vector Extensions 2 (AVX2). Using AVX2, up to eight floating point operations can be executed per cycle per core, potentially doubling the performance relative to non-AVX2 processors running at the same clock speed. Note that AVX2 support is not enabled by default and compiler flags must be set as described below.

#### GPU Nodes
Expanse GPU nodes have GNU, Intel, and PGI compilers available along with multiple MPI implementations (OpenMPI, IntelMPI, and MVAPICH2). The gcc/10.2.0, Intel, and PGI compilers have specific flags for the Cascade Lake architecture. Users should evaluate their application for best compiler and library selections.

*Note that the login nodes are not the same as the GPU nodes, therefore all GPU codes must be compiled by requesting an interactive session on the GPU nodes.*

In this tutorial, we include several hands-on examples that cover many of the cases described below, or the [Running Jobs](#run-jobs) section below.

* MPI
* OpenMP
* HYBRID
* GPU
* Local scratch

---
### AMD Optimizing C/C++ Compiler (AOCC)

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
| C       | clang | mpiclang | icc -fopenmp | mpicc -fopenmp |
| C++     | clang++ | mpiclang | icpc -fopenmp | mpicxx -fopenmp |

### Using the AOCC Compilers

* If you have modified your environment, you can reload by executing the module purge & load commands at the Linux prompt, or placing the load command in your startup file (~/.cshrc or ~/.bashrc)

In this example, we show how to reload your environment and how to use the ```swap``` command.
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

---
### Intel Compilers

The Intel compilers and the MVAPICH2 MPI implementation will be loaded by default. The MKL and related libraries may need several modulrs. If you have modified your environment, you can reload by executing the following commands such as those shown below at the Linux prompt or placing in your startup file (~/.cshrc or ~/.bashrc). Below is the list of modules created for the DGEMM MKL example described below  (on 01/25/21):

```
module purge
module load slurm
module load cpu
module load intel mvapich2
```

Recall that the list of modules being loaded depends on the application you are using and the compiler and libraries you may need. In some cases you will need to use the __module spider__ command to sort out what modules your application will need.  And, it is possible the list will change if some of the dependent software changes.

For AVX2 support, compile with the -march=core-avx2 option. Note that this flag alone does not enable aggressive optimization, so compilation with -O3 is also suggested.

Intel MKL libraries are available as part of the "intel" modules on Expanse. Once this module is loaded, the environment variable MKL_ROOT points to the location of the mkl libraries. The MKL link advisor can be used to ascertain the link line (change the MKL_ROOT aspect appropriately).

In the example below, we are working with a serial MKL example that can be found in the examples/MKL/dgemm folder of the GitHub repository.
This example based on an [Intel MKL repo](http://software.intel.com/en-us/articles/intel-sample-source-code-license-agreement/)
computes the real matrix ```C=alpha*A*B+beta*C``` using Intel(R) MKL

* Repository contents:
```
[username@login01] hpctr-examples/mkl/mkl-mat-mul/dgemm_mat_mul]$ ll
total 3758
drwxr-xr-x 2 user abc123       8 Jan 29 00:45 .
drwxr-xr-x 3 user abc123        3 Jan 29 00:25 ..
-rw-r--r-- 1 user abc123     2997 Jan 29 00:25 dgemm_example.f
-rw-r--r-- 1 user abc123      618 Jan 29 00:25 dgemm-Slurm.sb
-rw-r--r-- 1 user abc123      363 Jan 29 00:32 README.txt
```

* Code snippets:
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
[username@login01] dgemm]$ cat README.txt

[1] Compile:

module purge
module load slurm gpu
module load intel mvapich2 intel-mkl

ifort -o dgemm_example  -mkl -static-intel dgemm_example.f

[2] Run:

sbatch dgemm-slurm.sb

NOTE: for other compilers, replace "gcc"
with the one you want to use.
```

* Contents of the batch script:

```
[username@login01] dgemm]$ cat dgemm-Slurm.sb
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
module load slurm gpu
module load intel mvapich2 intel-mkl

## Use srun to run the job
srun --mpi=pmi2 -n 128 --cpu-bind=rank dgemm_example
```

* An example of the output:

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

---
### GNU Compilers
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


---
### PGI Compilers
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

---
