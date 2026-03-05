## Managing Accounts on Expanse
This page covers account visibility, project selection in batch jobs, and user management.

### Expanse-Client Script

* The expanse-client script provides additional details regarding User and Project availability and usage located at:

```
/cm/shared/apps/sdsc/current/bin/expanse-client
```

* Example of Script Usage:

```
[username@login01] ~]$ expanse-client -h
Allows querying the user statistics.

Usage:
  expanse-client [command]

  Available Commands:
    completion  Generate the autocompletion script for the specified shell
    help        Help about any command
    project     Get project information
    resource    Get resources
    user        Get user information

  Flags:
    -a, --auth      authenticate the request
    -h, --help      help for expanse-client
    -p, --plain     plain no graphics output
    -v, --verbose   verbose output

Use "expanse-client [command] --help" for more information about a command.
```

* Example of using the script shows that the user has allocations on 3 accounts, and SU's remaining:

```
[username@login01] ~]$ expanse-client user -p

 Resource  sdsc_expanse

 NAME     PROJECT  USED  AVAILABLE  USED BY PROJECT
----------------------------------------------------
 user  abc123     33      80000              180
 user  srt456      0       5000               79
 user  xyz789    318     500000          2905439
```

* To see who is on an account:

```
[username@login01] hpctr-examples]$ expanse-client project abc123
 Resource          expanse
 Project           abc123
 TG Project        xyz789  
 Total allocation  50000
 Total spent       1987
 Expiration        April 16, 2023

╭─────┬──────────────┬────────┬──────┬───────────┬─────────────────╮
│     │ NAME         │ STATUS │ USED │ AVAILABLE │ USED BY PROJECT │
├─────┼──────────────┼────────┼──────┼───────────┼─────────────────┤
│   9 │ user100      │ allow  │  500 │       500 │            1987 │
│  28 │ user101      │ allow  │   34 │       500 │            1987 │
│  31 │ user102      │ uspent │  514 │       500 │            1987 │
│  32 │ user103      │ allow  │  495 │       500 │            1987 │
│  79 │ user104      │ allow  │   67 │       500 │            1987 │
│  89 │ user105      │ allow  │   82 │       500 │            1987 │
│ 114 │ user106      │ allow  │   31 │       500 │            1987 │
│ 156 │ user107      │ allow  │   82 │       500 │            1987 │
╰─────┴──────────────┴────────┴──────┴───────────┴─────────────────╯
    (example is filtered)                                                               
```

### Using Accounts in Batch Jobs
As with the case above, some users will have access to multiple accounts (e.g. an allocation for a research project and a separate allocation for classroom or educational use). Users should verify that the correct project is designated for all batch jobs. Awards are granted for a specific purposes and should not be used for other projects. Designate a project by replacing  << project >> with a project listed as above in the SBATCH directive in your job script:

```
  #SBATCH -A << project >>
```

### Managing Users on an Account
Only project PIs and co-PIs can add or remove users from an account. This can only be done
via the ACCESS Allocations Management page at: https://allocations.access-ci.org/ web page (there is no command line interface for this).
After logging in, go to the Manage User page for the account.



---
## Job Charging

The basic charge unit for all SDSC machines, including Expanse, is the Service Unit (SU). This corresponds to:
* 1 CPU - use of one compute core utilizing less than or equal to 2G of data for one hour.
* 1 GPU using less than 96G of data for 1 hour.
* Shared resources - based on either the number of cores or the fraction of the memory requested, whichever is larger
* Charges are based on  resources that are tied up by your job not how the resources are used. 
* The minimum charge for any job is 1 SU.

See the [Expanse User Guide](https://www.sdsc.edu/support/user_guides/expanse.html#charging) for more details and factors that affect job charging.

