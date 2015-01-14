Coding test for NWEA

* Why did you choose this solution?

It was the most direct. 

At first I looked at using puppet. (To do so I taught myself puppet since I had never used it before.)
Puppet on Fedora 21 is unusable as installed. (It works on other distributions. The bug is one that
showed up in Redhat Enterprise. It was fixed there, but not in Fedora 21.) In building the install it became
clear that puppet is good if you have a working configuration, but it requires having knowledge of the
machine names and other information to install it correctly. (It is also overkill for this task.)

I then went to the fallback of writing a script in Perl and just doing a local install. 

* What is the best/worst part of your solution?

Best:

   It should work on any rpm based version of Linux. (Including SUSE.)

Worst:

   The install does not open the firewall ports automatically. There are too many wanys this can be done across distrobutions.

* Why would automating a task like this be helpful?

It would help if you have admins who have not installed/configured nginx before. It can also speed up the installs on multiple machines
by running the script over ssh.

Installation instructions:

Run the install script in the directory containing the fires from the git repository on the machine where you want the program installed.

./install-nginx.pl

and the program will do the rest.

NOTE: This program must be run as root or suid.
