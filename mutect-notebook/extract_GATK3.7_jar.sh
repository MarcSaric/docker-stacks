#!/usr/bin/env bash
# Hack out the official jar file for GATK 3.7.0
# See #114
docker pull broadinstitute/gatk3:3.7-0
export CONTAINER_ID=`docker create broadinstitute/gatk3:3.7-0`
echo $CONTAINER_ID
docker cp $CONTAINER_ID:/usr/GenomeAnalysisTK.jar ./GenomeAnalysisTK.jar
docker rm $CONTAINER_ID

