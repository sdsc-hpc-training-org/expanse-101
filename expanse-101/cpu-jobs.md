## Compiling and Running CPU Jobs

This page covers environment checks and CPU job workflows for MPI, OpenMP, and hybrid MPI+OpenMP.

---
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
sbatch hello_mpi_Slurm.sb
```

---
### Checking Your Environment
This simple batch script will show you how to check your user environment
and to also verify that your Slurm environment is working.

* Script contents:

```
[username@login01] ENV_INFO]$ cat env-Slurm.sb
#!/bin/bash
#SBATCH --job-name="envinfo"
#SBATCH --output="envinfo.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --export=ALL
#SBATCH -A sds173
#SBATCH -t 00:1:00

## Load module environment
module purge
module load slurm
module load cpu
module load sdsc

##  perform some basic unix commands

echo "----------------------------------"
echo "hostname= " `hostname`
echo "date= " `date`
echo "whoami= " `whoami`
echo "pwd= " `pwd`
echo "module list= " `module list`
echo "----------------------------------"
echo "env= " `env`
echo "----------------------------------"
echo "expanse-client user -p: " `expanse-client user -p`
echo "----------------------------------"

```
* Note that you can also see some Slurm environment variables, such as the JOB_ID. See the Slurm page: https://www.glue.umd.edu/hpcc/help/slurmenv.html
* Submit the batch script and monitor until the job is allocated a node,
and completes execution:

```

[username@login01] ENV_INFO]$ sbatch env-Slurm.sb
Submitted batch job 1088090
[username@login01] ENV_INFO]$ squeue -u user
           1088090   compute  envinfo  user PD       0:00      1 (ReqNodeNotAvail,[SNIP]
[...]
[username@login01] ENV_INFO]$ squeue -u user
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           1088090   compute  envinfo  user PD       0:00      1 (ReqNodeNotAvail, [SNIP]
```


### Hello World (MPI) 
**Subsections:**
* [Hello World (MPI): Source Code](#hello-world-mpi-source)
* [Hello World (MPI): Compiling](#hello-world-mpi-compile)
* [Hello World (MPI): Batch Script Submission](#hello-world-mpi-batch-submit)
* [Hello World (MPI): Batch Script Output](#hello-world-mpi-batch-output)
* [Hello World (MPI): Interactive Jobs](#hello-world-mpi-interactive)

---
#### Hello World (MPI): Source Code 
* Change to the tutorial `MPI` examples directory:
* Source code with basic MPI elements:
* Source code in F90
```
[username@login01] MPI]$ cat hello_mpi.f90 
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
[username@login01] MPI]$ 
```

* Source Code in C:


```
[username@login01] MPI]$ cat hello_mpi.c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);

    // Get the number of processes
    int comm_world;
    MPI_Comm_size(MPI_COMM_WORLD, &comm_world);

    // Get the rank of the process
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // Get the name of the processor
    char proc_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(proc_name, &name_len);

    printf("Hello world from processor %s, rank %d out of %d processors\n",
           proc_name, rank, comm_world);

    // Finalize the MPI environment.
    MPI_Finalize();
}
```

---
#### Hello World (MPI): Compiling 
* To compile, checkout the instructions in the **README.txt** file.
* Follow the instructions in the batch script provided for the compiler you want to test.

```
[username@login01] MPI]$ cat README.txt 
[1] Compile:

#### MODULE ENV: updated 01/28/2020 (MPT)
 module purge
 module load slurm
 module load cpu
 module load gcc/10.2.0
 module load openmpi/4.0.4

mpif90 -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:

sbatch hellompi-Slurm.sb

[2b] Run using interactive node:

To run on an interactive node, you need to use the salloc command.
_salloc_ - Obtain a Slurm job allocation (a set of nodes), execute a command, and then release the allocation when the command is finished.
For more information, see the Slurm page: https://slurm.schedmd.com/salloc.html

```

* Set your environment on the node:
```
[username@login02 mpi]$ module purge
[username@login02 mpi]$ module load slurm
[username@login02 mpi]$ module load cpu
[username@login02 mpi]$ module load gcc/10.2.0
[username@login02 mpi]$ module load openmpi/4.0.4
```

* Follow the compile instructions for the compiler that you want to use:

```
module purge
[username@login02 mpi]$ module load slurm
[username@login02 mpi]$ module load cpu
[username@login02 mpi]$ module load gcc/10.2.0
[username@login02 mpi]$ module load openmpi/4.0.4
[username@login02 MPI]$ module list
Currently Loaded Modules:
1) slurm/expanse/21.08.8   2) cpu/0.15.4   3) gcc/10.2.0   4) openmpi/4.0.4
```

* Next, compile the code:

```
[username@login02 mpi]$  mpif90 -o hello_mpi_f90 hello_mpi.f90
```

---
#### Hello World (MPI): Batch Script Submission 

* The batch script contains the module commands needed to set the right environment
in order to run the code. The contents of the default batch script are:

```
[username@login01] MPI]$ cat hellompi-Slurm.sb
#!/bin/bash
#SBATCH --job-name="hellompi"
#SBATCH --output="hellompi.%j.%N.out"
#SBATCH --partition=compute
####SBATCH --partition=shared
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=12
#SBATCH --export=ALL
#SBATCH -t 00:04:00
#SBATCH -A abc123

# This job runs with 3 nodes, and a total of 12 cores.
## Environment
### MODULE ENV: updated 01/28/2020 (MPT)
 module purge
 module load slurm
 module load cpu
 module load gcc/10.2.0
 module load openmpi/4.0.4

## Use srun to run the job
srun --mpi=pmi2 -n 12 --cpu-bind=rank ./hello_mpi

```

* In this batch script we are using the GNU compiler, and asking for 2 CPU compute nodes, with 128 tasks per node for a total of 256 tasks.
* the name of job is set in line 2, while the name of the output file is set in line 3, where "%j" is the Slurm JOB_ID, and and "%N" is the compute node name. You can name your outupt file however you wish, but it helpful to keep track of the JOB_ID and node info in case something goes wrong.

* Submit the batch script Submission using the sbatch commmand and monitor the job status using the squeue command:

```
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  user PD       0:00      2 (Priority)
[username@login01] MPI]$ squeue -u user -u user
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  user PD       0:00      2 (Priority)
[username@login01] MPI]$ squeue -u user -u user
^[[A             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  user CF       0:01      2 exp-2-[28-29]
[username@login01] MPI]$ squeue -u user -u user
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
667424   compute hellompi  user  R       0:02      2 exp-2-[28-29]
[username@login01] MPI]$ squeue -u user -u user
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
[username@login01] MPI]$ ll
total 151
drwxr-xr-x 2 user abc123    13 Dec 10 01:06 .
drwxr-xr-x 8 user abc123     8 Oct  8 04:16 ..
-rwxr-xr-x 1 user abc123 21576 Oct  8 03:12 hello_mpi
-rw-r--r-- 1 user abc123  8448 Oct  8 03:32 hellompi.667424.exp-2-28.out
[username@login01] MPI]$

```

---
#### Hello World (MPI): Batch Script Output 
Batch Script Output

```

[username@login01] MPI]$
[username@login01] MPI]$ cat hellompi.667424.exp-2-28.out
 node           1 : Hello world!
 node           0 : Hello world!
 [snip]
 node         247 : Hello world!
 node         254 : Hello world!
 node         188 : Hello world!
 node         246 : Hello world!

 ```

---
#### Hello World (MPI): Interactive Jobs 

* To run on an interactive node, you need to use the _salloc_ command.
* _salloc_ - Obtain a Slurm job allocation (a set of nodes), execute a command, and then release the allocation when the command is finished.
* For more information, see the Slurm page: https://slurm.schedmd.com/salloc.html

```
[username@login02 ~]$ salloc --nodes=2 --ntasks-per-node=4 --cpus-per-task=2 -p debug --account=use300 -t 00:30:00 --mem=5G
salloc --nodes=2 --ntasks-per-node=4 --cpus-per-task=2 -p debug --account=use300 -t 00:30:00 --mem=5G
salloc: Pending job allocation 21592400
salloc: job 21592400 queued and waiting for resources
salloc: job 21592400 has been allocated resources
salloc: Granted job allocation 21592400
salloc: Waiting for resource configuration
salloc: Nodes exp-9-[55-56] are ready for job
[username@login02 ~]$
```
* Note: You are now on an interactive node -- even though the node name on the unix prompt did not change.
* Note: You may not be in the same directory

* Next, load the module environment on the compute node. Don't depend on the system to propagate the right modules to the compute node.
```
[username@ exp-9-55 MPI]$ module purge
[username@ exp-9-55 MPI]$ module load slurm
[username@ exp-9-55 MPI]$ module load cpu
[username@ exp-9-55 MPI]$ module load gcc/10.2.0
[username@ exp-9-55 MPI]$ module load openmpi/4.0.4
```
* Compile your code if needed:

```
[username@exp-9-55 MPI]$ mpif90 -o hello_mpi_f_gnu hello_mpi.f90 
```

* You can now run your job from the command line using _mpirun_ or _srun_:

```
[username@login02 mpi]$ mpirun -np 8 ./hello_mpi_f90
 node           5 : Hello world! F90
 node           6 : Hello world! F90
 node           4 : Hello world! F90
 node           1 : Hello world! F90
 node           3 : Hello world! F90
 node           2 : Hello world! F90
 node           0 : Hello world! F90
 node           7 : Hello world! F90

[username@login02 mpi]$ srun --mpi=pmi2 -n 8 ./hello_mpi_f90
 node           0 : Hello world! F90
 node           3 : Hello world! F90
 node           2 : Hello world! F90
 node           1 : Hello world! F90
 node           4 : Hello world! F90
 node           7 : Hello world! F90
 node           5 : Hello world! F90
 node           6 : Hello world! F90

```

---
### Hello World (OpenMP) 
**Subsections:**
* [Hello World (OpenMP): Source Code](#hello-world-omp-source)
* [Hello World (OpenMP): Compiling](#hello-world-omp-compile)
* [Hello World (OpenMP): Batch Script Submission](#hello-world-omp-batch-submit)
* [Hello World (OpenMP): Batch Script Output](#hello-world-omp-batch-output)

---
#### Hello World (OpenMP): Source Code  
* Source Code in F90:

```
      PROGRAM OMPHELLO
      INTEGER TNUMBER
      INTEGER OMP_GET_THREAD_NUM

!$OMP PARALLEL DEFAULT(PRIVATE)
      TNUMBER = OMP_GET_THREAD_NUM()
      PRINT *, 'HELLO FROM THREAD NUMBER = ', TNUMBER
!$OMP END PARALLEL

      END

```

---
#### Hello World (OpenMP): Compiling 

* First, load the correct module environment:

```
module purge
module load slurm
module load cpu/0.15.4
module load aocc
module load openmpi/4.0.4



Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) cpu/0.15.4   3) aocc/2.2.0

```

* Next, compile the code:

```
flang -fopenmp -o hello_openmp hello_openmp.f90
```

---
#### Hello World (OpenMP): Batch Script Submission 
* Batch Script contents:

```

#!/bin/bash
## Example of OpenMP code running on a shared node
#SBATCH --job-name="hell_openmp_shared"
#SBATCH --output="hello_openmp_shared.%j.%N.out"
#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --export=ALL
#SBATCH --account=sds173
#SBATCH -t 00:10:00

# AOCC environment
module purge
module load slurm
module load cpu/0.15.4
module load aocc
module load openmpi/4.0.4

#SET the number of openmp threads
export OMP_NUM_THREADS=16

#Run the openmp job
./hello_openmp

```
* Note that the script is loading the module stack, and setting the number of OMP threads.

* Submit the job to the batch queue, and monitor:

```
[username@login02 OPENMP]$ sbatch openmp-Slurm-shared.sb ;  squeue -u user
Submitted batch job 1088802
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           1088802    shared hell_ope  user PD       0:00      1 (None)

```

---
#### Hello World (OpenMP): Batch Script Output 
Batch Script Output

```
[username@login02 OPENMP]$ cat hello_openmp_shared.1088802.exp-3-08.out
 HELLO FROM THREAD NUMBER =            14
 HELLO FROM THREAD NUMBER =            15
 HELLO FROM THREAD NUMBER =            10
 HELLO FROM THREAD NUMBER =             8
 HELLO FROM THREAD NUMBER =            12
 HELLO FROM THREAD NUMBER =             4
 HELLO FROM THREAD NUMBER =             1
 HELLO FROM THREAD NUMBER =             0
 HELLO FROM THREAD NUMBER =             9
 HELLO FROM THREAD NUMBER =             7
 HELLO FROM THREAD NUMBER =            11
 HELLO FROM THREAD NUMBER =             2
 HELLO FROM THREAD NUMBER =             5
 HELLO FROM THREAD NUMBER =            13
 HELLO FROM THREAD NUMBER =             3
 HELLO FROM THREAD NUMBER =             6
[username@login02 OPENMP]$

```

* Note the non-deterministic output of the thread numbers. This is normal for HPC systems.

---
### Compiling and Running Hybrid (MPI + OpenMP) Jobs 
**Subsections:**
* [Hybrid (MPI + OpenMP): Source Code](#hybrid-mpi-omp-source)
* [Hybrid (MPI + OpenMP): Compiling](#hybrid-mpi-omp-compile)
* [Hybrid (MPI + OpenMP): Batch Script Submission](#hybrid-mpi-omp-batch-submit)
* [Hybrid (MPI + OpenMP): Batch Script Output](#hybrid-mpi-omp-batch-output)

---
#### Hello World Hybrid (MPI + OpenMP): Source Code 

* Source Code: hybrid.c.

```
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
    printf("Hello from thread %d out of %d from process %d out of %d on %s\n",
           iam, np, rank, numprocs, processor_name);
  }

  MPI_Finalize();
}

```
---
#### Hello World Hybrid (MPI + OpenMP): Compiling 
Compiling.

* Compile code, but remember to load the right modules (see README.txt)

```
[1] Compile:

module purge
module load slurm
module load cpu
module load intel
module load intel-mpi

export I_MPI_CC=icc
mpicc -qopenmp -o hello_hybrid hello_hybrid.c

[2] Run:

sbatch hybrid-Slurm.sb

```

* Compilation example:

```
[username@login01] HYBRID]$ module purge
[username@login01] HYBRID]$ module load slurm
[username@login01] HYBRID]$ module load cpu
[username@login01] HYBRID]$ module load intel
[username@login01] HYBRID]$ module load intel-mpi
[username@login01] HYBRID]$ export I_MPI_CC=icc
[username@login01] HYBRID]$ mpicc -qopenmp -o hello_hybrid hello_hybrid.c

```

---
#### Hello World Hybrid (MPI + OpenMP): Batch Script Submission 

* Submit the batch script and monitor:

```
[username@login01] HYBRID]$ sbatch hybrid-Slurm.sb
Submitted batch job 1089019
    JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
[username@login01] HYBRID]$ squeue -u user
[username@login01] HYBRID]$ squeue -u user
    JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)

```

---
#### Hello World Hybrid (MPI + OpenMP): Batch Script Output 

* Batch Script Output:

```
[username@login01] HYBRID]$ cat hellohybrid.1089019.exp-10-07.out
Hello from thread 0 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 14 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 1 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 4 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 12 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 2 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 13 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 7 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 3 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 8 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 0 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 3 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 13 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 14 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 6 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 7 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 11 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 12 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 4 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 1 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 5 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 15 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 11 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 9 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 5 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 2 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 6 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 9 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 8 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 10 out of 16 from process 1 out of 2 on exp-10-07
Hello from thread 10 out of 16 from process 0 out of 2 on exp-10-07
Hello from thread 15 out of 16 from process 0 out of 2 on exp-10-07

```

---
