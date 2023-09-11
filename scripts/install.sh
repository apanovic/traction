#! /bin/bash

python3 --version > /dev/null 2>&1 && PYTHON=python3 || PYTHON=python

root_dir=$1
shift

# Allow a second argument to specify build-only
if [ -n "$1" ] ; then
    action=$1
    shift
else
    action=install
fi

echo "Will $action, install target is $root_dir."

# Bail out if anything goes wrong
set -e

# Add new packages below, minding the order as some packages depend on each
# other. What's commented out doesn't currently work
packages=(
    trac
    accountmanagerplugin
    ldapacctmngrplugin
    defaultccplugin
    autocompleteusersplugin
#    subticketsplugin
    graphvizplugin
    
)

# Build everything first
for package in ${packages[@]}; do
    
    if [ -z "$PYTHONPATH" ] ; then
        # The python site-packages is where everything goes, but the directory
        # may not exist yet. The first time around that's fine.
        export PYTHONPATH=`find $root_dir -name site-packages`
    fi


    ( cd $package && $PYTHON setup.py $action --root=$root_dir)
done
    
