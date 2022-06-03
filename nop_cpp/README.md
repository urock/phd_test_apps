# Network operator

## how to build
```
git submodule update --init --recursive 
mkdir build
cd build
cmake ..
make
```

## Run tests
```
cd build/test
./nop_tests 
# or
./nop_tests --gtest_filter="NOP.*"
```





