## Compiling and Running GPU Jobs 
This page covers GPU node usage, interactive GPU sessions, and CUDA/OpenACC example jobs.

---
### Using Expanse GPU Nodes 

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
* Be sure to setup  your CUDA environment for the compiler that you want to use:   
   * For CUDA codes, you will need the cuda Compiler. Expanse has several CUDA compiler libraries

```
#Environment for the CUDA Compiler
module purge
module load slurm
module load gpu/0.15.4
module load gcc/7.2.0
module load cuda/11.0.2
```
* Notes:
  * NVIDIA compiler command is *nvcc*
  * The Portland/PGI compilier commabnd is "pgcc"
  * Expanse has several CUDA compiler libraries, and you can see them by
   running *module avail* (once you have loaded the gpu module)

   ```
   ------------------------------------ /cm/shared/modulefiles ------------------------------------
      cuda10.2/blas/10.2.89      cuda10.2/profiler/10.2.89    sdsc/1.0
      cuda10.2/fft/10.2.89       cuda10.2/toolkit/10.2.89     xsede/xdusage/2.1-1
      cuda10.2/nsight/10.2.89    default-environment

   ```

   * For OpenACC codes, you will need the PGI Compiler:

```
#Environment for the PGI Compiler
module purge
module load slurm
module load gpu/0.15.4
module load pgi/20.4
```

---
#### Using Interactive GPU Nodes  
* Interactive GPU node:

```
[username@login01] OpenACC]$srun --partition=gpu-debug --pty --account=use300 --ntasks-per-node=10 --nodes=1 --mem=96G --gpus=1 -t 00:30:00 --wait=0 --export=ALL /bin/bash
srun: job 1089081 queued and waiting for resources
srun: job 1089081 has been allocated resources
[username@exp-7-59 OpenACC]$

```

* You can tell you are on an interactive compute node because the node name has changed from "login01" to "exp-7-59"

#### Obtaining GPU/CUDA: Node Information

* Once you are on an interactive node, reload the module environment:

```
[username@exp-7-59 OpenACC]$
[mthomas@exp-7-59 ~]$ module purge
[mthomas@exp-7-59 ~]$ module load slurm
[mthomas@exp-7-59 ~]$ module load gpu/0.15.4
[mthomas@exp-7-59 ~]$ module load gcc/7.2.0
[mthomas@exp-7-59 ~]$ module load cuda/11.0.2
[mthomas@exp-7-59 ~]$ module list

Currently Loaded Modules:
  1) slurm/expanse/21.08.8   2) gpu/0.15.4 (g)   3) gcc/7.2.0   4) cuda/11.0.2

  Where:
   g:  built natively for Intel Skylake

```

* You can also check node configuration using the nvidia-smi command:

```

[mthomas@exp-7-59 ~]$ nvidia-smi
Wed Oct 11 04:10:33 2023       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 525.85.12    Driver Version: 525.85.12    CUDA Version: 12.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:18:00.0 Off |                    0 |
| N/A   34C    P0    41W / 300W |      0MiB / 32768MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+

```
---
#### GPU Compiling:
All Compiling for GPU codes must be done on an interactive node:
Steps to compile the code:

1. Obtain an interactive node
2. Load the right Modules
3. Compile the Source code
4. Run code locally, or exit interactive node and submit the batch script

### Hello World (GPU-CUDA) 

**Subsections:**
* [Hello World (GPU-CUDA): Source Code](#hello-world-cuda-source)
* [Hello World (GPU-CUDA): Compiling](#hello-world-cuda-compile)
* [Hello World (GPU-CUDA): Execute](#hello-world-execute)
* [Hello World (GPU-CUDA): Batch Script Submission](#hello-world-cuda-batch-submit)
* [Hello World (GPU-CUDA): Batch Script Output](#hello-world-cuda-batch-output)

---
#### Hello World (GPU-CUDA): Source Code 
Hello World (GPU-CUDA): Source Code:

```
/*
* Copyright 1993-2010 NVIDIA Corporation. All rights reserved. *
* NVIDIA Corporation and its licensors retain all intellectual property and
*
* Updated by Mary Thomas, April 2023, for simple cuda compile example
*/
#include <stdio.h>
__global__ void kernel( void ) { }
int main( void ) { kernel<<<1,1>>>();
printf( "Hello,  SDSC HPC Training World!\n" ); return 0;
}

```

---
#### Hello World (GPU-CUDA): Compiling 
*Load the correct modules for the CUDA Compiler:

```
module purge
module load slurm
module load gpu/0.15.4
module load gcc/7.2.0
module load cuda/11.0.2
```

* Purge the old environment:

```
[username@login01] cd ~/hpctr-examples/cuda/hello-world
[username@login01] hello-world]$ module purge
[username@login01] hello-world]$ module load slurm
[username@login01] hello-world]$ module load gpu
[username@login01] hello-world]$ module load cuda
[username@login01] hello-world]$ module list

Currently Loaded Modules:
  1) slurm/expanse/21.08.8   2) gpu/0.15.4   3) cuda/11.0.2
```

* Compile the code from the command line on the interactive node:

```
[username@login01] hello-world]$ nvcc -o hello_world hello_world.cu
[username@login01] hello-world]$ ll hello_world*
-rwxr-xr-x 1 username use300 668704 Apr 11 02:08 hello_world
-rw-r--r-- 1 username use300    372 Apr 11 02:08 hello_world.cu
```

---
#### Hello World (GPU-CUDA): Execute
* Execute the code from the command line on an interactive node:

```
[username@login01] hello-world]$ ./hello_world
Hello,  SDSC HPC Training World!

```

---
#### Hello World (GPU-CUDA): Batch Script Submission 
* Exit the interactive node.
* Submit the job using the *sbatch* command, and monitor it while it is running using the *squeue* command:

Batch script contents:
```
[username@login01] hello-world]$ cat hello-world.sb
#!/bin/bash
#SBATCH --job-name="hello_world"
#SBATCH --output="hello_world.%j.%N.out"
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --mem=377393M
#SBATCH --account=use300
#SBATCH --no-requeue
#SBATCH -t 00:05:00

# Load the GPU Environment:
module purge
module load slurm
module load gpu/0.15.4
module load gcc/7.2.0
module load cuda/11.0.2

```

*Submit the job:

```
[username@login01] hello-world]$ sbatch hello-world.sb ; squeue -u username;
Submitted batch job 21591890
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          21591890       gpu hello_wo  username PD       0:00      1 (Priority)
[username@login01] hello-world]$ squeue -u username
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          21591890       gpu hello_wo  username  R       0:01      1 exp-2-60
[username@login01] hello-world]$ squeue -u username
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

---
#### Hello World (GPU-CUDA): Batch Script Output 

```
[username@login01] hello-world]$ ls -al *21591890*
-rw-r--r-- 1 username use300 44 Apr 11 02:20 hello_world.21591890.exp-2-60.out
[username@login01] hello-world]$ cat hello_world.21591890.exp-2-60.out
= 21591890
Hello,  SDSC HPC Training World!
```

---
### Vector Addition (GPU-CUDA) 
**Subsections:**
* [Vector Addition (GPU-CUDA): Source Code](#vec-add-cuda-source)
* [Vector Addition (GPU-CUDA): Compiling & Running](#vec-add-cuda-compile)
* [Vector Addition (GPU-CUDA): Batch Script Submission](#vec-add-cuda-batch-submit)
* [Vector Addition (GPU-CUDA): Batch Script Output](#vec-add-cuda-batch-output)

---
#### Vector Addition (GPU-CUDA): Source Code 

```
[username@login01] addition]$ cat vector_add_gpu.cu
// UCSD Phys244
// Spring 2018
// Andreas Goetz (agoetz@sdsc.edu)

// CUDA program to add two vectors in parallel on the GPU
// launch all kernels at once
//

#include<stdio.h>

// define vector length and threads per block
#define N (255*4096)
#define TPB 512

//
// CUDA device function that adds two integer vectors
//
__global__ void add(int *a, int *b, int *c, int n){

  int tid = threadIdx.x + blockIdx.x * blockDim.x;

  if (tid < n)
    c[tid] = a[tid] + b[tid];

}

//
// main program
//
int main(void){

  int *h_a, *h_b, *h_c;
  int *d_a, *d_b, *d_c;
  int size = N * sizeof(int);
  int i, nblock, err;

  // allocate host memory
  h_a = (int *) malloc(size);
  h_b = (int *) malloc(size);
  h_c = (int *) malloc(size);

// allocate device memory
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // initialize vectors
  for (i=0; i<N; i++){
    h_a[i] = i+1;
    h_b[i] = i+1;
  }

  // copy input data to device
  cudaMemcpy(d_a, h_a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, h_b, size, cudaMemcpyHostToDevice);

  // add vectors by launching a sufficient number of blocks of the add() kernel
  nblock = (N+TPB-1)/TPB;
  printf("\nLaunching vector addition kernel...\n");
  printf("Vector length     = %d\n",N);
  printf("Blocks            = %d\n",nblock);
  printf("Threads per block = %d\n",TPB);
  printf("Kernel copies     = %d\n",nblock*TPB);
  add<<<nblock,TPB>>>(d_a, d_b, d_c, N);

  // copy results back to host
  cudaMemcpy(h_c, d_c, size, cudaMemcpyDeviceToHost);

  // deallocate memory
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  // check results
  err = 0;
  for (i=0; i<N; i++){
    if (h_c[i] != 2*(i+1)) err += 1;
  }
  if (err != 0){
    printf("\n Error, %d elements do not match!\n\n", err);
  } else {
    printf("\n Success! All elements match.\n\n");
  }

  // deallocate host memory
  free(h_a);
  free(h_b);
  free(h_c);

  return err;

}
```

---
#### Vector Addition (GPU-CUDA): Compiling & Running 

```
[username@exp-7-59 addition]$ module purge
[username@exp-7-59 addition]$ module load slurm
[username@exp-7-59 addition]$ module load gpu
[username@exp-7-59 addition]$ module load cuda
[username@exp-7-59 addition]$ nvcc -o vector_add_gpu vector_add_gpu.cu
[username@exp-7-59 addition]$ exit
```



---
#### Vector Addition (GPU-CUDA): Batch Script Submission 

* Once you are done compiling, exit the GPU node, and submit the batchscript:

[mthomas@login01 addition]$ sbatch vector_add_gpu.sb 
Submitted batch job 25649417
[mthomas@login01 addition]$ squeue -u mthomas
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          25649417 gpu-share vector_a  mthomas  R       0:00      1 exp-14-60



---
#### Vector Addition (GPU-CUDA): Batch Script Output 


  ```
[mthomas@login01 addition]$ cat vector_add_gpu.25649417.exp-14-60.out

Launching vector addition kernel...
Vector length     = 1044480
Blocks            = 2040
Threads per block = 512
Kernel copies     = 1044480

 Success! All elements match.

[mthomas@login01 addition]$ 
```


---
### Laplace2D (GPU/OpenACC) 
**Subsections:**
* [Laplace2D (GPU/OpenACC): Source Code](#laplace2d-gpu-source)
* [Laplace2D (GPU/OpenACC): Compiling](#laplace2d-gpu-compile)
* [Laplace2D (GPU/OpenACC): Batch Script Submission](#laplace2d-gpu-batch-submit)
* [Laplace2D (GPU/OpenACC): Batch Script Output](#laplace2d-gpu-batch-output)

#### Laplace2D (GPU/OpenACC): Source Code  
Source Code

```
[username@login01] OpenACC]$ !cat
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

---
#### Laplace2D (GPU/OpenACC): Compiling  
Compile the code:
1. obtain an interactive node
2. load the right Modules
3. compile the Source code
4. exit interactive node


```
[username@login01] ~]$ module load slurm
[username@login01] ~]$ srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-debug -A abc123 --gpus=1 -t 00:10:00 /bin/bash
srun: job 667263 queued and waiting for resources
srun: job 667263 has been allocated resources
[username@exp-7-59 ~]$ module purge
[username@exp-7-59 ~]$ module load slurm
[username@exp-7-59 ~]$ module load gpu
[username@exp-7-59 ~]$ module load pgi
[username@exp-7-59 ~]$ module list

Currently Loaded Modules:
  1) slurm/expanse/20.02.3   2) gpu/1.0   3) pgi/20.4

```

* Now you are set up to compile the code:

```
[username@exp-7-59 OpenACC]$ pgcc -o laplace2d.openacc.exe -fast -Minfo -acc -ta=tesla:cc70 laplace2d.c
"laplace2d.c", line 91: warning: missing return statement at end of non-void
          function "laplace"
  }
  ^

GetTimer:
     20, include "timer.h"
          61, FMA (fused multiply-add) instruction(s) generated
laplace:
     47, Loop not fused: function call before adjacent loop
         Loop unrolled 8 times
         FMA (fused multiply-add) instruction(s) generated
     55, StartTimer inlined, size=2 (inline) file laplace2d.c (37)
     59, Generating create(Anew[:][:]) [if not already present]
         Generating copy(A[:][:]) [if not already present]
         Loop not vectorized/parallelized: potential early exits
     61, Generating implicit copy(error) [if not already present]
     64, Loop is parallelizable
     66, Loop is parallelizable
         Generating Tesla code
         64, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
             Generating implicit reduction(max:error)
         66, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */
     75, Loop is parallelizable
     77, Loop is parallelizable
         Generating Tesla code
         75, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
         77, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */
     88, GetTimer inlined, size=9 (inline) file laplace2d.c (54)
[username@exp-7-59 OpenACC]$
[username@exp-7-59 OpenACC]$ exit
```

---
#### Laplace2D (GPU/OpenACC): Batch Script Submission  
* Batch Script Contents

```

[username@exp-7-59 OpenACC]$ cat openacc-gpu-shared.sb
#!/bin/bash
#SBATCH --job-name="OpenACC"
#SBATCH --output="OpenACC.%j.%N.out"
#SBATCH --partition=gpu-shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=1
#SBATCH --acount=abc123
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

```
[username@login01] OpenACC]$ sbatch openacc-gpu-shared.sb
Submitted batch job 1093002
[username@login01] OpenACC]$ squeue -u username
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
[username@login01] OpenACC]$ ll
total 106
drwxr-xr-x  2 username use300     8 Jan 29 16:25 .
drwxr-xr-x 10 username use300    10 Jan 29 03:28 ..
-rw-r--r--  1 username use300  2136 Jan 29 03:27 laplace2d.c
-rwxr-xr-x  1 username use300 52080 Jan 29 16:20 laplace2d.openacc.exe
-rw-r--r--  1 username use300   234 Jan 29 16:25 OpenACC.1093002.exp-7-57.out
-rw-r--r--  1 username use300   332 Jan 29 16:11 openacc-gpu-shared.sb
-rw-r--r--  1 username use300  1634 Jan 29 03:27 README.txt
-rw-r--r--  1 username use300  1572 Jan 29 03:27 timer.h

```


---
#### Laplace2D (GPU/OpenACC): Batch Script Output  

* Batch Script Output:

```
[username@login01] OpenACC]$ cat OpenACC.1093002.exp-7-57.out
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
 total: 1.029057 s
[username@login01] OpenACC]$
```
