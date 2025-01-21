# Используем официальный образ Ubuntu 16.04 в качестве базового
FROM ubuntu:16.04

# Устанавливаем переменные окружения для предотвращения интерактивного режима
ENV DEBIAN_FRONTEND=noninteractive

# Обновляем список пакетов и устанавливаем базовые утилиты
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        vim \
        wget \
        curl \
        git \
        unzip \
        build-essential \
        software-properties-common \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

# Создаем нового пользователя gpadmin с паролем gpadmin и добавляем его в группу sudo
RUN useradd -m -s /bin/bash gpadmin && \
    echo "gpadmin:gpadmin" | chpasswd && \
    adduser gpadmin sudo && \
    echo "gpadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Устанавливаем рабочую директорию
WORKDIR /workspace

# Переключаемся на пользователя gpadmin
USER gpadmin

# Указываем команду по умолчанию для запуска контейнера
CMD ["/bin/bash"]