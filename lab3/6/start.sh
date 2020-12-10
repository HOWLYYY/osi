#!/bin/bash

bash han.sh&pid=$!
bash gen.sh $pid
