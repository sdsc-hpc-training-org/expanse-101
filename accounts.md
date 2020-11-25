## <a name="sys-env"></a>Managing Accounts on Expanse
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
```(base) localhost:~ username$ ssh -l username login.expanse.sdsc.edu
Last login: Wed Oct  7 11:04:17 2020 from 76.176.117.51
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
drwxr-xr-x 6 username use300 6 Oct  7 14:15 .
drwxr-xr-x 5 username use300 8 Oct  7 14:15 ..
drwxr-xr-x 2 username use300 6 Oct  7 14:15 HYBRID
drwxr-xr-x 2 username use300 6 Oct  7 14:15 MPI
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OpenACC
drwxr-xr-x 2 username use300 6 Oct  7 14:15 OPENMP
[username@login01 examples]$ ls -al examples/MPI
total 63
drwxr-xr-x 2 username use300     6 Oct  7 14:15 .
drwxr-xr-x 6 username use300     6 Oct  7 14:15 ..
-rwxr-xr-x 1 username use300 21576 Oct  7 14:15 hello_mpi
-rw-r--r-- 1 username use300   329 Oct  7 14:15 hello_mpi.f90
-rw-r--r-- 1 username use300   464 Oct  7 14:15 hellompi-slurm.sb
-rw-r--r-- 1 username use300   181 Oct  7 14:15 README.txt

```
All examples will contain source code, along with a batch script example so you can compile and run all examples on Expanse.

### Expanse User Portal<a name="user-portal"></a>
<img src="../images/expanse_usesr_portal.png" alt="Expanse User Portal" width="400px" />

* See: https://portal.expanse.sdsc.edu
* Quick and easy way for Expanse users to login, transfer and edit files and submit and monitor jobs. 
* Gateway for launching interactive applications such as MATLAB, Rstudio
* Integrated web-based environment for file management and job submission.
* All Users with valid Expanse Allocation and XSEDE Based credentials have access via their XSEDE credentials..


[Back to Top](#top)
<hr>
