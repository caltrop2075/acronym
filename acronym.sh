#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# acronym maker
# done solely in bash, no awk
#
# picks out all capital letters & numbers & special characters [-*+./:]
# now works with any input & sorts output
#
# 2023-07-18 added character separation [-*+./:]
#
# !!!WARNING!!!
# if this is used by another script that is reading STDIN pipe or redirect
# this program will read ALL of STDIN
# I thought that a script ran in its own environment...
# this could be a BUG...
# reporting a BASH BUG is next to impossible
# the people listed in the 'man page' probably don't work on the project anymore
#
# the Linux Community is HARD to deal with, with their attitude
#     YOU'RE AN IDIOT & I AM A LINUX GOD!
#     BWA HA HA...
#     YOU MINUSCULE INSIGNIFICANT LINUX USER,
#     BOW BEFORE MY MASSIVE LINUX KNOWLEDGE!
# not nice at all...
#
# 2024-02-22 added inline comment detection
#     comment must be have space '# comment'
#-------------------------------------------------------------------------------
source ~/data/global.dat
dat="$HOME/data/acronym.dat"     # default data file
pad=0
#-------------------------------------------------------------------------------
function fx_acr
{
   l=${#lin}
   str=""
   skp=0
   for ((i=0;i<l;i++))
   do
      chr=${lin:$i:1}
      if [[ $chr == "#" ]]       # comment - quit reading
      then
         skp=1
      fi
      if [[ $skp == 0 ]] && [[ $chr =~ [A-Z] || $chr =~ [0-9] || $chr =~ [-*+./:] ]]
      then
         str=$str$chr
      fi
   done
   n=$((10-${#str}))              # > > > change acronym width < < <
   for((i=0;i<n;i++))
   do
      if (($pad))
      then
         str=$str" "
      else
         str=$str"․"             # default file only
      fi
   done
   txt=${lin%% #*}               # remove comment
   txt=$(echo $txt)              # trim whitespace
   cmt=${lin#*# }                # comment
   if [[ "$txt" == "$cmt" ]]
   then
      printf "%s%s\n" "$str" "$txt"
   else
      n=$((40-${#txt}))          # > > > change text width < < <
      for((i=0;i<n;i++))
      do
         if (($pad))
         then
            txt=$txt" "
         else
            txt=$txt"․"          # default file only
         fi
      done
      printf "%s%s${grn}# %s${nrm}\n" "$str" "$txt" "$cmt"
   fi
}
#-------------------------------------------------------------------------------
function fx_inp
{
   while read lin
   do
      if [[ !(${lin:0:1} == "#" || $lin == "") ]]  # filter comment & blank
      then
         fx_acr
      fi
   done
}
#-------------------------------------------------------------------------------
function fx_hlp
{
   echo -e "usage:"
   echo -e "   cat filename | acronym.sh"
   echo -e "   acronym.sh < filename"
   echo -e "   acronym.sh filename"
   echo -e "   acronym.sh -h/--help"
   echo -e "   acronym.sh string"
   echo -e "   acronym.sh (no command, default file /data/acronym.dat)"
}
#-------------------------------------------------------------------------------
                                 # pipe & redirect
if [ -p /dev/stdin ]             # pipe: cat ~/data/acronym.dat | acronym.sh
then
   flg=1
   fx_inp | sort
elif [ -s /dev/stdin ]           # redirect: acronym.sh < ~/data/acronym.dat
then
   flg=1
   fx_inp | sort
elif (( $# > 0 ))                # command line
then
   if [ -f "$1" ]                # file: acronym.sh ~/data/acronym.dat
   then
      export flg=1
      title-80.sh -t line "acronym.sh using file $1\nvalid separators: -*+./:"
      sleep 2
      fx_inp < $1 | sort
   elif [[ $1 == "-h" || $1 == "--help" ]]
   then                          # help: acronym.sh -h/--help
      fx_hlp
   else                          # string: acronym.sh string
      lin=$1
      fx_acr
   fi
else                             # default file
   clear
   title-80.sh -t line "acronym.sh default file ~/data/acronym.dat\nvalid separators: -*+./:"
   sleep 2
   fx_inp < "$dat" | sort
fi
#-------------------------------------------------------------------------------
