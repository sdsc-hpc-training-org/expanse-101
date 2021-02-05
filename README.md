# [Expanse 101 Tutorial](https://github.com/sdsc-hpc-training-org/reverse-proxy/blob/master/README.md)
*Document last updated:  01/29/21*


## Expanse User Guide:
See:  [expanse.sdsc.edu](https://expanse.sdsc.edu)

[comment]: <> (a reference style link.
[https://github.com/sdsc-hpc-training-org/reverse-proxy/blob/master/README.md>
[[embed url=http://www.youtube.com/watch?v=6YbBmqUnoQM]]
)

## NOTES:

### Interactive Video Link:
This material was presented as part of a webinar presented on October 8th, 2020.
The link to the presentation will be posted soon:

[Interactive Video](https://education.sdsc.edu/training/interactive/202009_expanse_101/index.php)

### Hands-on Self-guided Tutorial (using markdown file):

[Self-guided Tutorial](https://github.com/sdsc-hpc-training-org/expanse-101/blob/master/running_jobs_on_expanse.md)

### Link to GitHub Repo
[https://github.com/sdsc-hpc-training-org/expanse-101](https://github.com/sdsc-hpc-training-org/expanse-101)

### Expanse User Guide
Please read the Expanse user guide and familiarize yourself with the hardware, file systems, batch job submission, compilers and modules. The guide can be found here:

[http://www.sdsc.edu/support/user_guides/expanse.html](http://www.sdsc.edu/support/user_guides/expanse.html)

### Basic Skills
You should be familiar with running basic Unix commands, connecting to Expanse via SSH, and other basic skills. See:
[https://github.com/sdsc-hpc-training/basic_skills](https://github.com/sdsc-hpc-training/basic_skills)



<hr>
In this tutorial, you will learn how to compile and run jobs on Expanse,
where to run them, and how to run batch jobs. The commands below can be
cut & pasted into the terminal window, which is connected to
expanse.sdsc.edu. For instructions on how to do this, see the tutorial
on how to use a terminal application and SSH go connect to an SDSC HPC
system: https://github.com/sdsc-hpc-training-org/basic_skills.


<a name="top">Contents:
* [Expanse Overview & Innovative Features](./docs/expanse_overview.md)
* [Getting Started](./getting_started.md)
* [Modules](./modules.md)
* [Account Management](./accounts.md)
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
## Misc Notes/Updates:

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
