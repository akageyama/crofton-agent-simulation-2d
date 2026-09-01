#!/bin/bash


(
for i in $(seq 0 0.02 1.1); do
  echo "&data00 contour_level_ = " $i "/" > _sgks.namelist

  ../runme _sgks.namelist
done
) | tee _sgks.output
