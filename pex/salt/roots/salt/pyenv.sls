install_pyenv:
  cmd.run:
    - name: curl https://pyenv.run | bash
    - unless:
      - which pyenv

/root/.bashrc:
  file.append:
    - text:
      - PATH="/root/.pyenv/bin:$PATH"
      - eval "$(pyenv init -)"
      - eval "$(pyenv virtualenv-init -)" 
    - watch:
      - cmd: install_pyenv

load_pyenv:
  cmd.run:
    - name: source /root/.bashrc
    - user: root
    - require:
      - file: /root/.bashrc

install_pipenv:
  pip.installed:
    - name: pipenv
