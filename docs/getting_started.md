## <a name="sys-env"></a>Getting Started on Expanse

<a name="top"> In this Section:
* [Expanse Accounts](#expanse-accounts)
* [Logging Onto Expanse](#expanse-logon)
* [Obtaining Example Code](#example-code)
* [Expanse User Portal](#user-portal)

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

For instructions on how to use SSH, see [Connecting to SDSC HPC Systems Guide](https://github.com/sdsc-hpc-training-org/hpc-security/tree/master/connecting-to-hpc-systems)
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

[Back to Top](#top)
<hr>

### Obtaining Example Code<a name="example-code"></a>
* Create a test directory hold the expanse example files:
```
hhhh
```
* Copy the `/share/apps/examples/expanse101/` directory to your local (`/home/username/expanse-examples`) directory. Note: you can learn to create and modify directories as part of the *Getting Started* and *Basic Skills* preparation work:
https://github.com/sdsc/sdsc-summer-institute-2020/tree/master/0_preparation
```
hhhh
```
Copy the 'expanse101' directory into your `expanse-examples` directory:
```
hhhh
```
Most examples will contain source code, along with a batch script example so you can run the example, and compilation examples (e.g. see the MKL example).

### Expanse User Portal<a name="user-portal"></a>
<img src="../images/expanse_usesr_portal.png" alt="Expanse User Portal" width="400px" />

* See: https://portal.expanse.sdsc.edu
* Quick and easy way for Expanse users to login, transfer and edit files and submit and monitor jobs. 
* Gateway for launching interactive applications such as MATLAB, Rstudio
* Integrated web-based environment for file management and job submission.
* All Users with valid Expanse Allocation and XSEDE Based credentials have access via their XSEDE credentials..


[Back to Top](#top)
<hr>
