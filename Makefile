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

lock-marquez:
	# step 3a
	# update marquez
	helm dependency update "./charts/marquez"

lock-airflow:
	# step 3b
	# update our chart
	helm dependency update "./charts/airflow"

release-airflow:
	# step 4a
	# install airflow chart
	helm upgrade airflow "./charts/airflow"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-marquez:
	# step 4b
	# install marquez chart
	helm upgrade marquez "./charts/marquez"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

cleanup:
	kind delete clusters de