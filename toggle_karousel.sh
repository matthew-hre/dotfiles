current=$(kreadconfig6 --file ~/.config/kwinrc --group Plugins --key karouselEnabled)

if [ "$current" = "true" ]; then
  kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key karouselEnabled false
elif [ "$current" = "false" ]; then
  kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key karouselEnabled true
fi

qdbus org.kde.KWin /KWin reconfigure
