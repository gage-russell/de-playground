kind-cluster:
	# step 1
	# create kind cluster
	kind create cluster --config="./kind/kind.yaml"

kind-get-cluster:
	# mostly just putting this here for memory
	# see running clusters
	kind get clusters

set-context:
	# step 2
	# connect kubectl to kind cluster
	kubectl config use-context kind-de
	kubectl config set-context --current --namespace=playground-ns

lock-localstack:
	# step 3c
	# update our chart
	helm dependency update "./charts/localstack"

release-localstack:
	# step 4c
	# install marquez chart
	helm upgrade localstack "./charts/localstack"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

# port forward localstack
# kubectl port-forward <pod> 4566:4566
# create bucket
# awslocal s3api create-bucket --bucket my-bucket
# list bucket contents
# awslocal s3 ls s3://my-bucket
# upload file
# awslocal s3 cp foo.txt s3://my-bucket/foo.txt
# awslocal s3 cp foo.txt s3://my-bucket/test-dir/foo.txt
# awslocal s3 cp foo.txt s3://my-bucket/test-dir/foo.txt/foo.txt
# awslocal s3 ls s3://my-bucket/test-dir/foo.txt

cleanup:
	kind delete clusters de