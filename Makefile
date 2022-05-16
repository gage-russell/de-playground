kind:
	# step 1
	# create kind cluster
	kind create cluster --config="./de/kind/kind.yaml"

kind-get-cluster:
	# mostly just putting this here for memory
	# see running clusters
	kind get clusters

kubectl-set-context:
	# step 2
	# connect kubectl to kind cluster
	kubectl config use-context kind-de

helm-lock-marquez:
	# step 3a
	# update marquez
	helm dependency update "./marquez"

helm-lock:
	# step 3b
	# update our chart
	helm dependency update "./de"

helm-install:
	# step 4
	# install our chart
	helm upgrade playground de\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	--set global.postgresql.auth.postgresPassword="macondo"\
 	 -f "./de/values.yaml"\
 	 --debug
