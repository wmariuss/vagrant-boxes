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

link_python:
  cmd.run:
    - name: ln -sfn /usr/bin/python3.6 /usr/bin/python
    - user: root

link_pip:
  cmd.run:
    - name: ln -sfn /usr/bin/pip3 /usr/bin/pip
    - user: root
    - require:
      - cmd: link_python

install_pipenv:
  pip.installed:
    - name: pipenv
    - user: root
    - watch:
      - cmd: link_pip
