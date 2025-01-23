#!/usr/bin/env bash
kubectl create namespace retro-aim-service
kubectl apply -f . -n retro-aim-service
