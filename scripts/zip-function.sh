#!/bin/bash

rm ../../build/$1.zip 
cd ../../../services/src/functions/$1
zip -X ../../../../terraform/build/$1.zip * >/dev/null 2>/dev/null
echo "{}"
