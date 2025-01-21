from datetime import datetime
from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.python_operator import PythonOperator

# Простая функция с выводом
def print_hello():
    return 'Hello, World!'

# Определяем класс DAG
dag = DAG(
    dag_id='hello_world',                  # Название DAG'а
    description='Simple Hello World DAG',  # Описание DAG'а
    schedule_interval='0 12 * * *',        # Расписание по CRON
    start_date=datetime(2024, 12, 19),      # Дата запуска DAG'а
    catchup=False                          # Запуск с текущей даты
)

# Создаём пустой таск start_task
start_task = EmptyOperator(
    task_id='start_pipeline',  # Название таска
    dag=dag                    # К какому DAG'у относится
)

# Задаём таск PythonOperator, котоырй вызывает функцию
hello_operator = PythonOperator(
    task_id='hello_task',         # Название таска
    python_callable=print_hello,  # Вызываемая функция
    dag=dag                       # К какому DAG'у относится
)

start_task >> hello_operator