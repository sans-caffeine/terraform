#!/bin/bash

rm ../../build/$1.zip 
cd ../../../services/src/functions-edge/$1
zip -X ../../../../terraform/build/$1.zip * >/dev/null 2>/dev/null
zip -jX ../../../../terraform/build/$1.zip ../config/configuration.json >/dev/null 2>/dev/null
echo "{}"
