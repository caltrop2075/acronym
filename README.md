# acronym
acronym generator

acro-sub.awk
--------------------------------------------------------------------------------
acronym expansion
using regular expressions
RSTART & RLENGTH generated by match()

acro-sub.sh
--------------------------------------------------------------------------------
acronym substitution/expansion
'fold' & 'fmt' escape color codes are counted causing uneven margins
escape color is not to be used when using formatting utilities

acronym.sh
--------------------------------------------------------------------------------
acronym maker
done solely in bash, no awk

picks out all capital letters & numbers & special characters [-*+./:]
now works with any input & sorts output

2023-07-18 added character separation [-*+./:]

!!!WARNING!!!
if this is used by another script that is reading STDIN pipe or redirect
this program will read ALL of STDIN
I thought that a script ran in its own environment...
this could be a BUG...
reporting a BASH BUG is next to impossible
the people listed in the 'man page' probably don't work on the project anymore

the Linux Community is HARD to deal with, with their attitude
    YOU'RE AN IDIOT & I AM A LINUX GOD!
    BWA HA HA...
    YOU MINUSCULE INSIGNIFICANT LINUX USER,
    BOW BEFORE MY MASSIVE LINUX KNOWLEDGE!
not nice at all...

2024-02-22 added inline comment detection
    comment must be have space '# comment'
