#!/bin/bash

#####################################################
# Name: kube_activity v0.1                          #
# Author: Arthur Enright                            #
# Email: arthur.enright@gmail.com                   #
#                                                   #
# Script that will create and destroy kubernetes    #
# deployments in order to generate cluster activity #
#####################################################

# Generate some deployment names
deplNames=$(shuf -n 5 /usr/share/dict/words)
for i in ${!deplNames[@]}; do
    echo ${deplNames[$i]}
done