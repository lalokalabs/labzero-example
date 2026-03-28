# Background

This document describes the evolution of `labzero-project` — how it started and why it ended up in its current form.

## Phase 1: Cookiecutter Template

The project originally started as a [Cookiecutter](https://cookiecutter.readthedocs.io/) template. Cookiecutter allows you to generate a project from a template by answering a few prompts, substituting variables throughout the generated files.

**Problems with this approach:**

- Maintaining a template is cumbersome — every change to the template requires a rebuild and re-testing of the generated output.
- Once a project is generated, it is permanently disconnected from the template. There is no way to receive future improvements or fixes.
- It adds a dependency on Cookiecutter itself, which users must install before they can get started.

## Phase 2: `rename.sh` Bash Script

To remove the Cookiecutter dependency, the project switched to a simpler approach: a plain bash script (`rename.sh`) that renames all key files and strings from the default project name (`myapp`) to whatever the user chooses.

**Improvements:**

- No external dependencies — just bash.

**Problems that remained:**

- The fundamental discontinuation problem was still there. Once the user ran `rename.sh`, the project diverged from the upstream template and could never receive updates.

## Phase 3: Git Submodules for Shared Features

As a workaround for the discontinuation problem, reusable features were extracted into separate applications:

- **[labzero](https://github.com/lalokalabs/labzero)** — core shared logic (admin dashboard, authentication, user management, etc.)
- **[django-umin](https://github.com/k4ml/django-umin)** — frontend asset integration with Vite

Both are included in `labzero-project` as git submodules under `ext-src/`. This allowed the shared code to evolve independently and be pulled in as updates.

**Problems that remained:**

- Some project-level files — `docker-compose.yml`, `Procfile`, `AGENTS.md`, deployment configs, etc. — still had to live directly in `labzero-project`.
- Any changes to those files in the upstream template were still lost once a user forked or cloned the project.
- The submodule model added friction: users had to understand and manage submodules.

## Phase 4: The Drupal Model (Current Direction)

The solution draws inspiration from how [Drupal](https://www.drupal.org/) was used in the early days of web development: you would check out Drupal core as your project, and build your own features as extensions (modules, themes) in sub-directories. Because you rarely touched Drupal core files, you could still run `git pull` to receive Drupal updates.

**The new approach for `labzero-project`:**

- Users **`git clone`** (or fork) `labzero-project` directly. They get a fully working project out of the box: admin dashboard, authentication, user management, frontend tooling, Docker setup, and more.
- The labzero core application lives in `src/labzero/`.
- Users add their own application code alongside it, e.g. `src/myapp/`, without touching the labzero core files.
- Because user code lives in its own directory and labzero core is rarely modified, users can periodically **`git pull`** (or sync their fork) from the upstream `labzero-project` to receive improvements, security fixes, and new features — just like pulling from Drupal core.

**Benefits:**

- No extra tooling required — just `git`.
- Continuous updates: user projects can stay in sync with the upstream template for the lifetime of the project.
- Clear separation between framework code (`src/labzero/`) and application code (`src/myapp/`).
- The full project structure — Docker Compose, Procfile, deployment configs, CI configuration — can also evolve upstream and be merged into user projects.
