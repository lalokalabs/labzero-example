web: PYTHONUNBUFFERED=1 uv run myapp manage runserver_plus
gunicorn: PYTHONUNBUFFERED=1 uv run myapp manage run_gunicorn -t 40 --serve-static
vit: npm run watch
mail: /usr/local/bin/mailpit --smtp-auth-allow-insecure