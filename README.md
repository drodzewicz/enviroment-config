# Teminal configuration steps

Customization of bash terminal is done using tool called *Powerline* which uses python.

## Install python

**Step 1:** You need to get dependency for adding custom PPAs. This is done by enabling common properties:

```
sudo apt install software-properties-common –y
```

**Step 2:** After this you need to move forward and add deadsnakes PPA to APT package manager sources list like:

```
add-apt-repository ppa:deadsnakes/ppa
```

**Step 3:** Once the repository has been added you can now download pythons new version with command line

```
sudo apt install python3.10
```

**Step 4:** To make sure the right release has been installed, you need to verify it. Below is how you can do it:

```
python –version
```


**Step 5:** You may also need to install *pip3*

```
sudo apt install python3-pip
```

## Intalling Powerline

**Step1:** Install base powerline package

```
pip3 install --user powerline-status
```

**Step2:** Install git portion of powerline package

```
pip3 install --user powerline-gitstatus
```

**Step3:** Look for Poweline daemon file

```
find / 2> /dev/null | grep powerline-daemon
```

get the path of the **powerline-daemon** file and save it for later

eg. */home/user/.local/bin/powerline-daemon*

**Step4:** Look for powerline.sh

```
find / 2> /dev/null | grep powerline.sh
```

get the path of the **../bash/powerline.sh** file and save it for later

eg. */home/user/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh*

**Step 5:** Now we are going to be configuring powerline in the profile file (bash_profile or bashrc). In this guide I was using a **~/.bashrc**

the fragment below can be copy and pasted into your profile file but two lines will need to be modified

```
export PATH="$PATH:/home/user/.local/bin/"
export LC_ALL=en_US.UTF-8
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /home/user/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
```

1. `export PATH="$PATH:/home/user/.local/bin/"` will most likely be different on other systems so to insert a correct path get the link from **step 3** *(in my case it was /home/user/.local/bin/powerline-daemon) copy everything that comes before /powerline-daemon* and paste the path after `$PATH:` in export  
2. `source /home/user/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh` use the path from **step 4**.

3. `export LC_ALL=en_US.UTF-8` is specific for the US english language system

**Step 6:** Create local directories with configuration for color schemas and themes.

```
mkdir -p ~/.config/powerline/colorschemes
mkdir -p ~/.config/powerline/themes/shell
```
*The -p flag will create nested directories, but only if they don't exist already.*

**Step 7:** get the path from **step 4** and copy everything before *../powerline/bindings/bash/powerline.sh*

from 

*/home/user/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh*

 we get 

 */home/user/.local/lib/python3.8/site-packages/powerline/*

**Step 8:** Now we will need to copy all the files from this path to our newly created direcotries for colorscheemes and themes

```
cp /home/user/.local/lib/python3.8/site-packages/powerline/colorschemes ~/.config/powerline/colorschemes

cp /home/user/.local/lib/python3.8/site-packages/powerline/themes/shell ~/.config/powerline/themes/shell
```

**Step 9:** The Gitstatus segment uses a couple of custom highlight groups. You'll need to define those groups in your colorscheme, for example in `~/.config/poweliner/colorchemes/default.json`

`nano ~/.config/poweliner/colorchemes/default.json`

and paste below fragment to groups
```
    "gitstatus":                 { "fg": "gray8",           "bg": "gray2", "attrs": [] },
    "gitstatus_branch":          { "fg": "gray8",           "bg": "gray2", "attrs": [] },
    "gitstatus_branch_clean":    { "fg": "green",           "bg": "gray2", "attrs": [] },
    "gitstatus_branch_dirty":    { "fg": "gray8",           "bg": "gray2", "attrs": [] },
    "gitstatus_branch_detached": { "fg": "mediumpurple",    "bg": "gray2", "attrs": [] },
    "gitstatus_tag":             { "fg": "darkcyan",        "bg": "gray2", "attrs": [] },
    "gitstatus_behind":          { "fg": "gray10",          "bg": "gray2", "attrs": [] },
    "gitstatus_ahead":           { "fg": "gray10",          "bg": "gray2", "attrs": [] },
    "gitstatus_staged":          { "fg": "green",           "bg": "gray2", "attrs": [] },
    "gitstatus_unmerged":        { "fg": "brightred",       "bg": "gray2", "attrs": [] },
    "gitstatus_changed":         { "fg": "mediumorange",    "bg": "gray2", "attrs": [] },
    "gitstatus_untracked":       { "fg": "brightestorange", "bg": "gray2", "attrs": [] },
    "gitstatus_stashed":         { "fg": "darkblue",        "bg": "gray2", "attrs": [] },
    "gitstatus:divider":         { "fg": "gray8",           "bg": "gray2", "attrs": [] }
```

**Step 10:** Then you can activate the Gitstatus segment by adding it to your segment configuration, for example in `.config/powerline/themes/shell/default.json`

`nano .config/powerline/themes/shell/default.json`

add in the **"left"** segment below fragment

```
{
    "function": "powerline_gitstatus.gitstatus",
    "priority": 40
}
```

## Installing powerline supported fonts
 
**Step 1:** clone a repository
```
git clone https://github.com/powerline/fonts.git --depth=1 powerline_fonts
```

**Step 2:** Install the fonts *(font repository that we have cloned have an instalation script **install.sh**)*
```
./powerline_fonts/install.sh
```

**Step 3:** In your terminal prefferences change the font to one of the fonts that you have just installed.

Fonts that will work with powerline have * for Powerline* in the name of the font.

exampe font: **Source Code Pro for Powerline Semibold** 

# Manage multiple git accounts

## Generate SSH key
Go to **.ssh** directory
```
cd ~/.ssh
```
Generate ssh key using ssh-keygen
```
ssh-keygen -t rsa -C "<mail_name>@<host>" -f "<key_name>"
```
Add the created SSH key to your SSH-agent.
```
ssh-add -K ~/.ssh/<key_name>
```

*If you see an error message saying "Could not open a connection to your authentication agent" you might need to turn on your ssh-agent.*
```
eval `ssh-agent -s`
```

## Add generated key to *(Github/Gitlab/Bitbucket/...)* account(s)
Copy public key and paste it in the ssh-key field on your chosen online respository hosting service.
```
cat ~/.ssh/<key_name>.pub
```

## Create a git config file
Create a config file inside of the **~/.ssh** directory
```
touch ~/.ssh/config
```
Add following specification for each managed account
```
Host github.com-example
  HostName github.com
  User git
  IdentityFile ~/.ssh/<key_name>
```
with following example you would have to add **-example** to the host when trying to clone the repository
```
git clone git@github.com-example:{repo-owner-user-name}/{repo-name}.git
```

## Mangae git config
For global config use following commans *(for local config just skipp the **--global** flag)*
```
git config --global user.name "<name>"
git config --global user.email "<email>"
```
or edit the file itself
```
nano ~/.gitconfig
```