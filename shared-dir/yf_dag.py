"""
Local DAG
"""
import datetime
import logging
from pprint import pprint

import pendulum

from airflow import DAG
from airflow.decorators import task

log = logging.getLogger(__name__)

with DAG(
    dag_id='a_local_dag',
    schedule_interval=None,
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
    tags=['local'],
) as dag:
    # [START howto_operator_python]
    @task(task_id="print_the_context")
    def print_context(ds=None, **kwargs):
        """Print the Airflow context and ds variable from the context."""
        pprint(kwargs)
        print(f'ds: {ds}')
        return 'Whatever you return gets printed in the logs'

    run_this = print_context()
    # [END howto_operator_python]

    @task(task_id="print_now")
    def print_now(ds=None, **kwargs):
        pprint(kwargs)
        print(f'ds: {ds}')
        now = datetime.datetime.utcnow()
        print(f'now: {now}')
        return str(now)

    run_that = print_now()

    run_that << run_this