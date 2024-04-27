#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# acronym substitution/expansion
# 'fold' & 'fmt' escape color codes are counted causing uneven margins
# escape color is not to be used when using formatting utilities
#-------------------------------------------------------------------------------
clear

WHT="\033[1;37m"
Wht="\033[0;37m"
nrm="\033[0m"
fil="$HOME/data/acro-sub.txt"          # text with acronymns
dat="$HOME/data/acro-sub.dat"          # acronym expansion data TAB delimited

title-80.sh -t line "Acronym Expansion Using AWK\ninput:\$HOME${fil#$HOME}\nacronym:\$HOME${dat#$HOME}"
echo -e "${Wht}ORIGINAL DATA${nrm}"
cat $fil | fold -sw 80
echo -e "\n${Wht}ACRONYM EXPANSION${nrm}"
cat $fil | acro-sub.awk | fold -sw 80
#-------------------------------------------------------------------------------
