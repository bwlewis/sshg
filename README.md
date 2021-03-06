sshg
====

A simple script that issues sshg commands to a group of nodes, either
explicitly specified or optionally detected from the Ganglia `gmond` daemon if
available. Standard I/O port redirection is supported and output is labeled by
node.

## Examples

Send `uname -a` as the current user to nodes "atlas" and "arbitrage". Note that
the output returns asynchronously and is labeled by default (use the `-q`
option to skip labels).
```
sshg atlas arbitrage "uname -a"

(atlas-1) Linux Atlas 3.11.0-17-generic #31~precise1-Ubuntu SMP Tue Feb 4 21:25:43 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
(arbitrage-1) Linux arbitrage 3.2.0-57-generic #87-Ubuntu SMP Tue Nov 12 21:35:10 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
```

Redirect standard output through the network in parallel to several nodes.
```
echo "Hello there" | sshg atlas arbitrage "cat"
(atlas-1) Hello there
(arbitrage-1) Hello there
```

That last example is really useful for copying files in parallel to many nodes.
For example, let's say we want to copy a directory called 'test' to the /tmp
directory on several nodes. We can redirect the output of tar:

```
mkdir test
touch test/example_file_1
touch test/example_file_2

tar -zcf - test | sshg atlas arbitrage "tar -C /tmp -zxvf -"
(atlas-1) test/
(atlas-2) test/example_file_2
(atlas-3) test/example_file_1
(arbitrage-1) test/
(arbitrage-2) test/example_file_2
(arbitrage-3) test/example_file_1
```

Commands are issued synchronously by default, although their output, if any,
may return asynchronously. Use the -f option to issue commands asynchronously
(and then sshg returns immediately).


## Installation

See the basic install.sh script, which simply copies the sshg bash script to
/usr/local/bin.

## Man page

<A NAME="lbAB">&nbsp;</A>
<H2>NAME</H2>

sshg - SSH/Group: Secure shell for multiple targets
<A NAME="lbAC">&nbsp;</A>
<H2>SYNOPSIS</H2>

<B>sshg</B>  [<I>options</I>] [<I>[user@]host1[,]</I>] [<I>[user@]host2][,]</I>] ... &quot;<I>command string</I>&quot;
<A NAME="lbAD">&nbsp;</A>
<H2>DESCRIPTION</H2>

Send the command string to the list of hosts using the ssh command. The host 
list
can be a list of individual node host names or I.P. addresses. 
The command string is evaluated in parallel. The standard input stream is
replicated and redirected to each ssh command. Standard output and error 
streams
are returned and displayed from each process. The output can be optionally
labeled and saved.
<A NAME="lbAE">&nbsp;</A>
<H2>OPTIONS</H2>

<DL COMPACT>
<DT>-a<DD>
Send the command string to all nodes. This option requires Gangalia gmond.
<DT>-c <I>cmd</I><DD>
Use <I>cmd</I> in place of ssh.
<DT>-f<DD>
Fork each ssh process to the background and return immediately. 
NOTE: Redirected stdin is not available to the shells when this option is
specified.
<DT>-h<DD>
Display this help.
<DT>-l <I>user</I><DD>
Send the ssh commands with the user name <I>user</I>.
<DT>-n <I>file</I><DD>
Use the list of nodes in file. The list may contain node host
names, I.P. addresses, or MPI-style (MPICH and/or LAM-MPI) node listings.
<DT>-o <I>option</I><DD>
Append the supplied SSH option to the ssh command. Any valid SSH option
can be specified here. Multiple -o options can be specified.
<DT>-p <I>prefix</I><DD>
Prepend the prefix to saved output files (see the -s option). Setting
this option additionally implies the -s option.
<DT>-s<DD>
Save the stdout/stderr streams from each shell process to output files.
The output files will be named <I>prefix</I>&lt;node&gt;.&lt;pid&gt;, where <I>prefix</I>
is set by the -p option, &lt;node&gt; is the node host name, and &lt;pid&gt; is the
Process id of the calling sshg command.
<DT>-q<DD>
Be quiet (suppress printing of messages and output labels).
<DT>-u <I>user</I><DD>
Send the command as the specified <I>user</I> (same as -l).
<DT>-v<DD>
Display the sshg version number.
<DT>-X<DD>
Enable X11 forwarding. Equivalent to -oForwardX11.
<DT>--debug<DD>
Display debugging information for the sshg command but don't invoke ssh.
<DT>--list<DD>
Summarized defined cluster groups and exit (Rocketcalc clusters only).
<DT>--fork<DD>
Fork the ssh commands to the background (same as -f).
</DL>
<A NAME="lbAF">&nbsp;</A>
<H2>AUTHOR</H2>

Written by B. Wayne Lewis, Rocketcalc LLC.
<A NAME="lbAG">&nbsp;</A>
<H2>COPYRIGHT</H2>

Copyright (C) 2002 Rocketcalc, LLC. This is free software--see the source
for copying conditions and discalaimer.
<A NAME="lbAH">&nbsp;</A>
<H2>SEE ALSO</H2>

<DL COMPACT>
<DT><B><A HREF="/cgi-bin/man/man2html?1+ssh">ssh</A></B>(1)<DD>
<DT><B><A HREF="/cgi-bin/man/man2html?1+scpg">scpg</A></B>(1)<DD>
<P>
</DL>

<HR>
<A NAME="index">&nbsp;</A><H2>Index</H2>
<DL>
<DT><A HREF="#lbAB">NAME</A><DD>
<DT><A HREF="#lbAC">SYNOPSIS</A><DD>
<DT><A HREF="#lbAD">DESCRIPTION</A><DD>
<DT><A HREF="#lbAE">OPTIONS</A><DD>
<DT><A HREF="#lbAF">AUTHOR</A><DD>
<DT><A HREF="#lbAG">COPYRIGHT</A><DD>
<DT><A HREF="#lbAH">SEE ALSO</A><DD>
</DL>
<HR>
This document was created by
<A HREF="/cgi-bin/man/man2html">man2html</A>,
