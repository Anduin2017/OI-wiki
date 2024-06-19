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
FROM nginx:alpine
COPY --from=python-env /app/site /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
