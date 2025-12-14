# -*- coding: utf-8 -*-

import os
import click

def init():
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "myapp.settings")
    import django

    django.setup()

@click.group()
def cli():
    init()

@click.command(
    context_settings=dict(
        ignore_unknown_options=True,
    )
)
@click.argument("manage_args", nargs=-1, type=click.UNPROCESSED)
def manage(manage_args):
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(["manage"] + list(manage_args))

@click.option("--address", "-b", default="127.0.0.1:9000")
@click.option("--serve-static/--no-serve-static", default=False)
@click.option("--reload/--no-reload", "reload_", default=False)
@click.option("--use-sentry", is_flag=True)
@click.option("--sentry-env", default="dev")
@click.command()
def run_gunicorn(address, use_sentry, sentry_env, serve_static=False, reload_=False):
    import sentry_sdk
    import multiprocessing
    from django.conf import settings
    from whitenoise import WhiteNoise
    from myapp.wsgi import application
    from gunicorn.app.base import BaseApplication
    from sentry_sdk.integrations.django import DjangoIntegration

    # Sentry integration
    if use_sentry:
        raise Exception("Set dsn parameter and remove this line")
        sentry_sdk.init(
            environment=sentry_env,
            dsn="",
            integrations=[DjangoIntegration()],
            # Set traces_sample_rate to 1.0 to capture 100%
            # of transactions for performance monitoring.
            # We recommend adjusting this value in production.
            traces_sample_rate=1.0,
            # If you wish to associate users to errors (assuming you are using
            # django.contrib.auth) you may enable sending PII data.
            send_default_pii=True,
        )

    class GunicornApplication(BaseApplication):
        def __init__(self, app, options=None):
            self.options = options or {}
            self.application = app
            super().__init__()

        def load_config(self):
            config = {
                key: value
                for key, value in self.options.items()
                if key in self.cfg.settings and value is not None
            }
            for key, value in config.items():
                self.cfg.set(key.lower(), value)

        def load(self):
            return self.application

    options = {
        "bind": address,
        "workers": (multiprocessing.cpu_count() * 2) + 1,
        "accesslog": "-",
        "reload": reload_,
    }

    if serve_static:
        static_dir = os.path.join(settings.BASE_DIR, "static")
        application = WhiteNoise(application, root=static_dir)
        application.add_files(static_dir, prefix="/static/")

    ret = GunicornApplication(application, options).run()
    return

@click.option("--name", default="dev")
@click.command()
def hello(name):
    print("Hello,", name)

cli.add_command(hello)

cli.add_command(manage)
cli.add_command(run_gunicorn)


def main():
    cli()
