#!/bin/sh
DIR=$( dirname $0 )
set -ev

# Check syntax
ansible-playbook -i $DIR/inventory -c local --syntax-check -vv $DIR/test.yml
# Check role
ansible-playbook -i $DIR/inventory -c local --become -vv $DIR/test.yml
# Check indempotence
ansible-playbook -i $DIR/inventory -c local --become -vv $DIR/test.yml \
  | grep -q 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0) \
  || (echo 'Idempotence test: fail' && exit 1)
