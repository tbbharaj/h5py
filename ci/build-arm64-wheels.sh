#!/bin/bash
set -e -u -x
ls -lrt

bash /src/ci/get_hdf5_arm64.sh

cd /src/
ls -lrt

# Create binary wheels
/opt/python/${PYTHON}/bin/pip wheel /src/ -w wheelhouse/
#python setup.py bdist_wheel

ls -lrt wheelhouse/

# Normalize resulting binaries to a common format
for whl in wheelhouse/cassandra_driver-*.whl; do
    auditwheel repair "$whl" -w wheelhouse/
done
