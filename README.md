# Quick test to see if localstack supports directory pattern: filename.ext/filename.ext
appears to work
## steps:
1. `make kind-cluster`
2. `make set-context`
3. `make lock-localstack`
4. `make release-localstack`
5. `kubectl port-forward <pod> 4566:4566`
6. `cd ./aws-local-files`
7. `sh create.sh`
8. `make cleanup`

## notes:
1. must have kind installed
2. must have aws cli installed
3. must have aws-local cli installed (can be pip installed)
