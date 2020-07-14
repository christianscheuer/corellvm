#!/bin/bash

CORERT=/d/d2/corert
ILCPATH=$CORERT/bin/OSX.x64.Debug

dotnet $CORERT/Tools/csc.exe /noconfig /nostdlib /runtimemetadataversion:v4.0.30319 zerosharp.cs /out:zerosharp.ilexe /langversion:latest /unsafe
$ILCPATH/tools/ilc zerosharp.ilexe -o zerosharp.obj --systemmodule zerosharp --map zerosharp.map -O
clang zerosharp.obj -Wl,-e,___managed__Main -o zerosharp

echo "Calling zerosharp..."

./zerosharp

RES=$?
echo "Result: $RES"
