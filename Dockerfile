FROM python:3.7.6
ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip install poetry
RUN pip install pillow==9.2.0

WORKDIR /device_anomaly_detection
COPY pyproject.toml /device_anomaly_detection

RUN poetry config virtualenvs.create false
RUN poetry install

COPY dp_final_of_ibrl_dataset_anomaly_detection_humidity.py /device_anomaly_detection
COPY dp_final_of_ibrl_dataset_anomaly_detection_temp.py /device_anomaly_detection
COPY final_of_ibrl_dataset_anomaly_detection_humidity.py /device_anomaly_detection
COPY final_of_ibrl_dataset_anomaly_detection_temp.py /device_anomaly_detection
COPY main.py /device_anomaly_detection
COPY data.txt /device_anomaly_detection

CMD \ 
	poetry run black --check . ; \
	poetry run pylint . ; \
	poetry run isort --check --diff . ; \ 
	poetry run flake8 ; \ 
	poetry run coverage run -m pytest main.py && poetry run coverage report -m