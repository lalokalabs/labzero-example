web: PYTHONUNBUFFERED=1 uv run manage.py runserver_plus
gunicorn: PYTHONUNBUFFERED=1 uv run manage.py run_gunicorn -t 40 --serve-static
vite: uv run manage.py vite_dev
mail: /usr/local/bin/mailpit --smtp-auth-allow-insecure
