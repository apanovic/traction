#! /bin/bash

export PYTHONPATH=`echo $PWD/usr/local/lib/python*/dist-packages/`
export PATH=$PWD/usr/local/bin/:$PATH

if [ ! -f htpasswd ]; then
    echo "Creating a default htpaswd with: admin/admin and test/test"
    cat > htpasswd <<EOF
admin:iXgOUUrbjs5YE
test:ScubdgNkKOvZU
EOF
fi

if [ ! -d env/test ]; then
    echo "No environment found, creating a new environment called 'test'"
    mkdir -p env
    trac-admin env/test initenv "Test Project" sqlite:db/trac.db
    trac-admin env/test permission add admin TRAC_ADMIN
fi

tracd --port 8000 \
      --basic-auth="test,htpasswd,eng" \
      env/test

