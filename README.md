Role Name
=========

A simple ansible role to deploy menuoper defined in menuoper_services 

This repo is configured with CI:

- molecule
- github actions
- pre-commit hook to execute ansible-lint

Requirements
------------

menuoper_services:
  - serv_desc: "Semaphore UI - Ansible Console"
    serv_name: "semaphore.service"
  - serv_desc: "BD PostgreSQL"
    serv_name: "postgresql.service"
  - serv_desc: "Qualis Cloud Agent"
    serv_name: "qualis-cloud-agent.service"

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
