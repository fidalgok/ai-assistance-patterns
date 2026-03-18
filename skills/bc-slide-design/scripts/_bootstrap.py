"""
Dependency bootstrap for bc-slide-design scripts.

Ensures required packages are available before the calling script runs.
- Local environments: creates a .venv alongside this file and installs into it,
  then re-launches the calling script with the venv Python so the global
  environment stays clean. This only happens once — subsequent runs detect the
  existing venv and skip setup.
- Sandboxed environments (API code execution): installs directly via pip since
  the environment is already isolated and disposable.
"""

import os
import subprocess
import sys

SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
VENV_DIR = os.path.join(SCRIPTS_DIR, ".venv")
REQUIREMENTS = os.path.join(SCRIPTS_DIR, "requirements.txt")

# Packages to check: {pip name: import name}
REQUIRED = {
    "python-pptx": "pptx",
    "beautifulsoup4": "bs4",
}


def _can_import(module_name):
    try:
        __import__(module_name)
        return True
    except ImportError:
        return False


def _imports_available():
    """Check if all required packages can be imported."""
    return all(_can_import(mod) for mod in REQUIRED.values())


def _in_sandbox():
    """Detect if we're running in an API code execution sandbox."""
    # Explicit env var (future-proof)
    if os.environ.get("ANTHROPIC_SANDBOX"):
        return True
    # Docker container detection
    if os.path.exists("/.dockerenv"):
        return True
    # Linux root with no user profile — likely a container
    if sys.platform != "win32" and os.getuid() == 0:
        return True
    return False


def _venv_python():
    """Path to the venv's Python executable."""
    if sys.platform == "win32":
        return os.path.join(VENV_DIR, "Scripts", "python.exe")
    return os.path.join(VENV_DIR, "bin", "python")


def _running_in_venv():
    """Check if the current Python is running inside our venv."""
    # sys.prefix points to the venv when activated or launched via venv python.
    # Can't compare executables — on macOS/Homebrew, venv python is a symlink
    # back to the system binary, so realpath() resolves both to the same file.
    return os.path.realpath(sys.prefix) == os.path.realpath(VENV_DIR)


def ensure_deps():
    """
    Make sure all required packages are importable.

    Call this at the top of each script before any domain imports.
    On first local run it creates a venv and re-launches — the caller
    never returns past this function in that case.
    """
    if _imports_available():
        return  # Nothing to do

    if _in_sandbox():
        # Sandbox: install directly, environment is disposable
        missing = [pkg for pkg, mod in REQUIRED.items() if not _can_import(mod)]
        if missing:
            subprocess.check_call(
                [sys.executable, "-m", "pip", "install", "-q"] + missing
            )
        return

    # Local environment: use a venv to keep things clean
    venv_py = _venv_python()

    if not os.path.exists(VENV_DIR):
        print(f"[bc-slide-design] Creating virtual environment at {VENV_DIR} ...")
        subprocess.check_call([sys.executable, "-m", "venv", VENV_DIR])
        subprocess.check_call(
            [venv_py, "-m", "pip", "install", "-q", "-r", REQUIREMENTS]
        )
        print("[bc-slide-design] Dependencies installed.")

    # Re-launch with the venv Python if we aren't already in it
    if not _running_in_venv():
        os.execv(venv_py, [venv_py] + sys.argv)
