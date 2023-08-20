#!/bin/bash

#####################################################
# Name: kube_activity v0.1                          #
# Author: Arthur Enright                            #
# Email: arthur.enright@gmail.com                   #
#                                                   #
# Script that will create and destroy kubernetes    #
# deployments in order to generate cluster activity #
#####################################################

# Define some terminal colors
RED='\033[0;31m'
YEL='\033[1;33m'
GRN='\033[0;32m'
NCL='\033[0m'

# Generate some deployment names
deplNames=( $(shuf -n 10 dictionary) )

# Create namespaces
echo ""
echo -e "${YEL}Creating namespaces${NCL}"
echo ""
for n in ${!deplNames[@]}; do
    	kubectl create ns ${deplNames[$n]}-ns
done

#kubectl get ns |grep ns

echo ""
echo -e "${GRN}Namespace creation complete${NCL}"
echo ""

# Create deployments in their namespaces
echo -e "${YEL}Creating deployments${NCL}"
echo ""
for d in ${!deplNames[@]}; do
	sleep $((30 + Random % 300 + RANDOM % 300));
	kubectl create deployment ${deplNames[$d]}-depl --image=nginx --replicas $((1 + RANDOM % 3)) -n ${deplNames[$d]}-ns
	echo "$(date)"
	echo ""
done
echo -e "${YEL}All deployments launched, deleting deployments...${NCL}"
echo ""

# Delete deployments
for d in ${!deplNames[@]}; do
        sleep $((60 + RANDOM % 120));
        kubectl delete deployment ${deplNames[$d]}-depl -n ${deplNames[$d]}-ns
        echo "$(date)"
        echo ""
done
echo -e "${GRN}All deployments deleted!${NCL}"
echo ""

# Delete namespaces
echo -e "${YEL}Deleting namespaces${NCL}"
for n in ${!deplNames[@]}; do
        kubectl delete ns ${deplNames[$n]}-ns
done

#kubectl get ns |grep ns

echo ""
echo -e "${YEL}Namespace deletion complete${NCL}"
echo ""
echo -e "${GRN}Exiting...${NCL}