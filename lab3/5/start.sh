#!/bin/bash 
mkfifo buffer
bash han.sh&bash gen.sh

rm buffer