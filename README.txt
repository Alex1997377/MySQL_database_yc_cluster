1.узнаем конфигурацию и данные нашего профиля yc cli
yc config profile get default

2.Задаем конфигурацию профиля
yc config set service-account-key key.json
yc config set cloud-id <идентификатор_облака>
yc config set folder-id <идентификатор_каталога>

Где:
service-account-key — файл с авторизованным ключом сервисного аккаунта. (лучше ключ скачать вручную с yc менеджера и добавить в папку Users)
cloud-id — идентификатор облака.
folder-id — идентификатор каталога.

3.Добавьте аутентификационные данные в переменные окружения:
$Env:YC_TOKEN=$(yc iam create-token)
$Env:YC_CLOUD_ID=$(yc config get cloud-id)
$Env:YC_FOLDER_ID=$(yc config get folder-id)

Где:
YC_TOKEN — IAM-токен.
YC_CLOUD_ID — идентификатор облака.
YC_FOLDER_ID — идентификатор каталога.

4.Прописываем заданную конфигурацию в terraform файл (файл locals.tf лучше прописать все переменные, ключи и пароли и добавить его .gitignor)

5.terraform init

6.terraform plan

7.terraform apply

Важно:
  1.перед тем как использовать terraform вместе Yandex Cloud провайдером необходимо  в терминале прописать: $env:APPDATA
  2.после того как узнали дирректорию патенциального расположения terraform CLI (его может не быть прийдется создавать самому)
  3.echo > terraform.rc
terraform.rc:
  provider_installation {
    network_mirror {
      url = "https://terraform-mirror.yandexcloud.net/"
      include = ["registry.terraform.io/*/*"]
    }
    direct {
      exclude = ["registry.terraform.io/*/*"]
    }
  }


ОПИСАНИЕ: 

  В данном репозитории реальзованно инфрастуктура создания кластера БД MySQL,
  которая емеет БД-копию, и в свою же очередь может реплицироваться при перегрузке.

