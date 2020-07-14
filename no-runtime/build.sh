#!/bin/bash

CORERT=/d/d2/corert
ILCPATH=$CORERT/bin/OSX.x64.Debug

echo
echo "Compiling C# -> IL..."
dotnet $CORERT/Tools/csc.exe /noconfig /nostdlib /runtimemetadataversion:v4.0.30319 zerosharp.cs /out:zerosharp.ilexe /langversion:latest /unsafe || exit -1

echo
echo "Compiling IL to native code..."
$ILCPATH/tools/ilc zerosharp.ilexe -o zerosharp.obj --systemmodule zerosharp --map zerosharp.map -O || exit -1

echo
echo "Linking..."
clang zerosharp.obj -Wl,-e,___managed__Main -o zerosharp || exit -1

echo
echo "Calling zerosharp..."

./zerosharp
RES=$?

echo
echo "Result: $RES"
