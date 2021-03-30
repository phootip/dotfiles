#!/bin/sh
source ~/.kube/staging-eks.sh
tmux new -s work \; \
renamew 'Staging' \; \
send-key 'source ~/.kube/staging-eks.sh' C-m \; \
splitw -h \; \
send-key 'source ~/.kube/staging-eks.sh' C-m \; \
\
neww -n 'Prod' \; \
send-key 'source ~/.kube/production-eks.sh' C-m \; \
splitw -h \; \
send-key 'source ~/.kube/production-eks.sh' C-m \; \

