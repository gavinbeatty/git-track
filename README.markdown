git-track
=========
Gavin Beatty <gavinbeatty@gmail.com>

git track: a simple shell script to ease the unnecessarily complex task of
tracking a branch, i.e., setting up a local branch to track a remote one.

In other words, set up `<local_branch>` to track
`refs/remote/<remote>/<remote_branch>`

    Usage: git track [-v] [-n] [-f] [-b <remote_branch>] [<remote> [<local_branch>]]
       or: git track [-v] [-n] -d <local_branch>

    <local_branch> is the local branch. If -b <remote_branch> is not used,
    <remote_branch> is <local_branch>

    <remote> is the remote to track to -- defaults to origin

    -v -- print each command as it is run.
    -n -- don't run any commands, just print them.
    -f -- don't do any checks on whether <local_branch> is tracking a branch
          already or that <remote_branch> exists.
    -b -- don't reuse <local_branch> for the remote branch and use
          <remote_branch>.
    -d -- stop <local_branch> from tracking anything.

    <remote> -- the remote where the branch you want to track exists.

    <local_branch> -- the local branch that will track the remote. If none
    given, use `git symbolic-ref HEAD`.


Dependencies
------------

* sh: in POSIX
* getopts: in POSIX.
* sed: in POSIX
* git: it is very much not in POSIX.

As such, git-track should be portable across all platforms that Git supports.


License
-------

git track Copyright 2010 Gavin Beatty <gavinbeatty@gmail.com>.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You can find the GNU General Public License at:
http://www.gnu.org/licenses/


Install
-------
Default prefix is /usr/local:
    sudo make install

Select your own prefix:
    make install prefix=~/.local


