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

lock-localfs:
	# step 3c
	# update our chart
	helm dependency update "./charts/localfs"

lock-superset:
	# step 3c
	# update our chart
	helm dependency update "./charts/superset"

lock-postgresql:
	# step 3c
	# update our chart
	helm dependency update "./charts/postgresql"

lock-localstack:
	# step 3c
	# update our chart
	helm dependency update "./charts/localstack"

release-airflow:
	# step 4a
	# install airflow chart
	helm upgrade airflow "./charts/airflow"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-localfs:
	# step 4b
	# install marquez chart
	helm upgrade localfs "./charts/localfs"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-marquez:
	# step 4c
	# install marquez chart
	helm upgrade marquez "./charts/marquez"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-superset:
	# step 4c
	# install marquez chart
	helm upgrade superset "./charts/superset"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-localstack:
	# step 4c
	# install marquez chart
	helm upgrade localstack "./charts/localstack"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-postgresql:
	# step 4c
	# install marquez chart
	helm upgrade postgresql "./charts/postgresql"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

release-superset-playground:
	helm upgrade postgresql "./charts/postgresql"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

	helm upgrade superset "./charts/superset"\
 	--install\
 	--create-namespace\
 	--namespace "playground-ns"\
 	 -f "./charts/values.yaml"\
 	 --debug

cleanup:
	kind delete clusters de