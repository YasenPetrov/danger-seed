#!/bin/bash

echo -n "Enter the git repository to link to: "
read repo;
git remote rm origin;
git remote add origin $repo;
echo "Changed remote origin to $repo";
