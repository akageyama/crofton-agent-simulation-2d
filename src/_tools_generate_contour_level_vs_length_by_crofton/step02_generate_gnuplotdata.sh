#!/bin/bash

cat _sgks.output | grep '## level' | awk '{print $3, $4}' > _sgks.output2
