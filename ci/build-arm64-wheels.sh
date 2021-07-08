#!/bin/bash
set -e -u -x
bash /src/ci/get_hdf5_arm64.sh

cd /src/

# Create binary wheels
/opt/python/${PYTHON}/bin/pip wheel /src/ -w wheelhouse/

ls -lrt wheelhouse/

# Normalize resulting binaries to a common format
for whl in wheelhouse/cassandra_driver-*.whl; do
    auditwheel repair "$whl" -w wheelhouse/
done
