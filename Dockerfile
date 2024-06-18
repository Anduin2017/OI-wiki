# ============================
# Prepare Build Environment
FROM python:3.10 as python-env
WORKDIR /app
COPY . .

RUN bash ./scripts/pre-build/install-theme.sh
RUN pip install pipenv
RUN pipenv install
RUN pipenv run mkdocs build -v

# ============================
# Prepare Runtime Environment
FROM hub.aiursoft.cn/aiursoft/static
COPY --from=python-env /app/site /data
