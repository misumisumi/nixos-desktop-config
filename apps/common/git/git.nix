/*
  Git conf
*/
{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userEmail = "dragon511southern@gmail.com";
      userName = "Sumi-Sumi";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      ignores = [
        # Byte-compiled / optimized / DLL files
        "__pycache__/"
        "*.py[cod]"
        "*$py.class"

        # C extensions
        "*.so"

        # Distribution / packaging
        ".Python"
        "build/"
        "develop-eggs/"
        "dist/"
        "downloads/"
        "eggs/"
        ".eggs/"
        "lib/"
        "lib64/"
        "parts/"
        "sdist/"
        "var/"
        "wheels/"
        "share/python-wheels/"
        "*.egg-info/"
        ".installed.cfg"
        "*.egg"
        "MANIFEST"

        # PyInstaller
        #  Usually these files are written by a python script from a template
        #  before PyInstaller builds the exe, so as to inject date/other infos into it.
        "*.manifest"
        "*.spec"

        # Installer logs
        "pip-log.txt"
        "pip-delete-this-directory.txt"

        # Unit test / coverage reports
        "htmlcov/"
        ".tox/"
        ".nox/"
        ".coverage"
        ".coverage.*"
        ".cache"
        "nosetests.xml"
        "coverage.xml"
        "*.cover"
        "*.py,cover"
        ".hypothesis/"
        ".pytest_cache/"
        "cover/"

        # Translations
        "*.mo"
        "*.pot"

        # Django stuff:
        "*.log"
        "local_settings.py"
        "db.sqlite3"
        "db.sqlite3-journal"

        # Flask stuff:
        "instance/"
        ".webassets-cache"

        # Scrapy stuff:
        ".scrapy"

        # Sphinx documentation
        "docs/_build/"

        # PyBuilder
        ".pybuilder/"
        "target/"

        # Jupyter Notebook
        ".ipynb_checkpoints"

        # IPython
        "profile_default/"
        "ipython_config.py"

        # pyenv
        #   For a library or package, you might want to ignore these files since the code is
        #   intended to run in multiple environments; otherwise, check them in:
        ".python-version"

        # pipenv
        #   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
        #   However, in case of collaboration, if having platform-specific dependencies or dependencies
        #   having no cross-platform support, pipenv may install dependencies that don't work, or not
        #   install all needed dependencies.
        "Pipfile.lock"

        # poetry
        #   Similar to Pipfile.lock, it is generally recommended to include poetry.lock in version control.
        #   This is especially recommended for binary packages to ensure reproducibility, and is more
        #   commonly ignored for libraries.
        #   https://python-poetry.org/docs/basic-usage/#commit-your-poetrylock-file-to-version-control
        "poetry.lock"

        # PEP 582; used by e.g. github.com/David-OConnor/pyflow
        "__pypackages__/"

        # Celery stuff
        "celerybeat-schedule"
        "celerybeat.pid"

        # SageMath parsed files
        "*.sage.py"

        # Environments
        ".env"
        ".venv"
        "env/"
        "venv/"
        "ENV/"
        "env.bak/"
        "venv.bak/"

        # Spyder project settings
        ".spyderproject"
        ".spyproject"

        # Rope project settings
        ".ropeproject"

        # mkdocs documentation
        "/site"

        # mypy
        ".mypy_cache/"
        ".dmypy.json"
        "dmypy.json"

        # Pyre type checker
        ".pyre/"

        # pytype static type analyzer
        ".pytype/"

        # Cython debug symbols
        "cython_debug/"

        # PyCharm
        #  JetBrains specific template is maintained in a separate JetBrains.gitignore that can
        #  be found at https://github.com/github/gitignore/blob/main/Global/JetBrains.gitignore
        #  and can be added to the global gitignore or merged into this file.  For a more nuclear
        #  option (not recommended) you can uncomment the following to ignore the entire idea folder.
        #.idea/

        # wandb
        ".wandb"

        # Haskell

        "dist"
        "dist-*"
        "cabal-dev"
        "*.o"
        "*.hi"
        "*.hie"
        "*.chi"
        "*.chs.h"
        "*.dyn_o"
        "*.dyn_hi"
        ".hpc"
        ".hsenv"
        ".cabal-sandbox/"
        "cabal.sandbox.config"
        "*.prof"
        "*.aux"
        "*.hp"
        "*.eventlog"
        ".stack-work/"
        "cabal.project.local"
        "cabal.project.local~"
        ".HTF/"
        ".ghc.environment.*"

        # VRChat (Unity)
        # From https://gist.github.com/aiya000/a9f3ab323f34c1746c0fc82aa3004230
        # Created by https://www.toptal.com/developers/gitignore/api/unity
        # Edit at https://www.toptal.com/developers/gitignore?templates=unity

        ### Unity ###
        # This .gitignore file should be placed at the root of your Unity project directory
        #
        # Get latest from https://github.com/github/gitignore/blob/master/Unity.gitignore
        "/[Tt]emp/"
        "/[Oo]bj/"
        "/[Bb]uild/"
        "/[Bb]uilds/"
        "/[Ll]ogs/"
        "/[Uu]ser[Ss]ettings/"
        # MemoryCaptures can get excessive in size.
        # They also could contain extremely sensitive data
        "/[Mm]emoryCaptures/"
        # Asset meta data should only be ignored when the corresponding asset is also ignored
        "!/[Aa]ssets/**/*.meta"
        # Uncomment this line if you wish to ignore the asset store tools plugin
        # /[Aa]ssets/AssetStoreTools*
        # Autogenerated Jetbrains Rider plugin
        "/[Aa]ssets/Plugins/Editor/JetBrains*"
        # Visual Studio cache directory
        ".vs/"
        # Gradle cache directory
        ".gradle/"
        # Autogenerated VS/MD/Consulo solution and project files
        "ExportedObj/"
        ".consulo/"
        "*.csproj"
        "*.unityproj"
        "*.sln"
        "*.suo"
        "*.tmp"
        "*.user"
        "*.userprefs"
        "*.pidb"
        "*.booproj"
        "*.svd"
        "*.pdb"
        "*.mdb"
        "*.opendb"
        "*.VC.db"
        # Unity3D generated meta files
        "*.pidb.meta"
        "*.pdb.meta"
        "*.mdb.meta"
        # Unity3D generated file on crash reports
        "sysinfo.txt"
        # Builds
        "*.apk"
        "*.unitypackage"
        # Crashlytics generated file
        "crashlytics-build.properties"
        # Autogenerated files
        "InitTestScene*.unity.meta"
        "InitTestScene*.unity"
        # End of https://www.toptal.com/developers/gitignore/api/unity
        "/[Ll]ibrary/*"
        "!/[Ll]ibrary/metadata"
        "!/[Ll]ibrary/assetDatabase3"
      ];
    };
  };
}
