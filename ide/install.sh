if [[ ! -d ~/.pivotal_ide_prefs ]]
then
  echo "  Installing ide prefs for you."
  git clone https://github.com/pivotal/pivotal_ide_prefs ~/.pivotal_ide_prefs
fi


cd ~/.pivotal_ide_prefs/cli
git stash
git pull
bin/ide_prefs --ide=intellij install
bin/ide_prefs --ide=webstorm install
bin/ide_prefs --ide=pycharm  install
cd ~

#bin/ide_prefs --ide=[rubymine,intellij,intellijcommunity,webstorm,androidstudio,pycharm] install
