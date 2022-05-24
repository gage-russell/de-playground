kind:
	# step 1
	# create kind cluster
	kind create cluster --config="./kind/kind.yaml"

kind-get-cluster:
	# mostly just putting this here for memory
	# see running clusters
	kind get clusters

kubectl-set-context:
	# step 2
	# connect kubectl to kind cluster
	kubectl config use-context kind-de
	kubectl config set-context --current --namespace=playground-ns

helm-lock-marquez:
	# step 3a
	# update marquez
	helm dependency update "./charts/marquez"

helm-lock-airflow:
	# step 3b
	# update our chart
	helm dependency update "./charts/airflow"

release-airflow:
	# step 4
	# install our chart
	helm upgrade airflow "./charts/airflow"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-marquez:
	# step 4
	# install our chart
	helm upgrade marquez "./charts/marquez"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

cleanup:
	kind delete clusters de