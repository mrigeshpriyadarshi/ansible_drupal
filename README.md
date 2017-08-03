# ansible_drupal

This application is an attempt to create opencms on Vagrant Box with three tiered architecture. The automation is enabled through Vagrant starting from box creation to application deployment by Ansible. 

Setup [Drupal](https://www.drupal.org/)  on your Vagrant Box with Ansible, you can install it from your laptop by making itself a Workstation

If you are fluent with [Ansible](http://docs.ansible.com/ansible/intro_getting_started.html), you know where to look and what to do. If you are new to Ansible and cloudformation, just follow along with step-by-step instructions below.


## Pre-requisites
* [Install git](https://git-scm.com/downloads)

* Install recent version of [Ansible](http://docs.ansible.com/ansible/intro_installation.html)

* Install recent version of [Vagrant](https://www.vagrantup.com/docs/installation/)
(v1.8.1 at the time of writing). For those unfortunate Windows users: [How to use Vagrant on Windows](http://tech.osteel.me/posts/2015/01/25/how-to-use-vagrant-on-windows.html) may sweeten your bitter.

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (version 5.0 and up), and
VirtualBox Extension packs ([follow instructions for Extension packs
here](https://www.virtualbox.org/manual/ch01.html#intro-installing)).

* Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/)

* Install [Test kitchen](http://kitchen.ci)

* Install certain kitchen plugins
	gem install kitchen-vagrant
	gem install kitchen-ansible

* Install vagrant plugins
	vagrant plugin install vagrant-hostsupdater


## Simple installation

Clone the ansible_drupal repo, and start up Ansible:

```bash

git clone https://github.com/mrigeshpriyadarshi/ansible_drupal.git
cd ansible_drupal

```

We have divided the whole implentation in four roles:-

* webserver - It would install and configure Apache on instance

* db - It would install and configure MySQL on DB instance.

* php - It would install and configure PHP7 instance

* composer - It would install and configure Drupal Composer instance.

* drush - It would install and configure Drush CLI on the instance.

* drupal - It would install and configure Drupal on the instance


Update [Common Ansible Vars](./group_vars/common.yaml) YAML with relevant data.

```
---
app_dir_base: /var/www/drupal
app_dir: "{{ app_dir_base }}/web"
servername: devops.gobear.dev

drupal_mysql_user: drupal
drupal_mysql_password: drupal
drupal_mysql_dbname: drupal

```

Then, execute following commands for vagrant to create the instance

```bash
vagrant up

or 

Kitchen converge

```

This command will download a vagrant box, create a virtual machine, and start ansible-playbook to provision the Drupal with version 8.3.5.


These command will create whole stack and then install the Drupal. After Completion you can hit the Webserver FQDN  (http://devops.gobear.dev/) in browser.

If something went wrong, jump to [Troubleshooting](https://github.com/mrigeshpriyadarshi/ansible_drupal#common-problems-and-solutions) section below.


## Verify the stack

Run kitchen verify to execute inspects tests to verify if all intended checks are satisfied.

```bash

kitchen verify

```


## Common problems and solutions

## Deletion of Stack

Once the testing completes, you can delete the stack to save the extra cost on Vagrant Box.

```
vagrant destroy

or

kitchen destroy

```


## Contribute

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request


## License

|  |  |
| ------ | --- |
| **Author:** | Mrigesh Priyadarshi |
| **Copyright:** | [Mrigesh Priyadarshi](mailto:mrigeshpriyadarshi@gmail.com) |
| **License:** | Apache License, Version 2.0 |

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

See [LICENSE](license) for more information.

ansible-playbook -i bootstrap.ini bootstrap-init.yaml
