# MC START SCRIPT BY WAKUSAY
SCREEN="ressource" #Name of the screen
NAME="ressource" #Name of the ressource
COMMAND="while true; do java -Xms10G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper.jar --nogui; echo 'Server restarting...'; sleep 10; done" #java start command

running(){
 if ! screen -list | grep -q "$SCREEN"
 then
  return 1
 else
  return 0
 fi
}

case "$1" in
 start)
  if ( running )
  then
    echo "Server [$NAME] is already running"
  else
    echo "Starting server [$NAME]"
    screen -dmS $SCREEN bash -c "$COMMAND"
  fi
  ;;
 status)
    if ( running )
    then
      echo "Running"
    else
      echo "Not running"
    fi
  ;;
 screen)
   screen -r $SCREEN
 ;;
 reload)
   screen -S $SCREEN -p 0 -X stuff `printf "reload\r"`
 ;;
 stop)
  if ( running )
  then
    screen -S $SCREEN -p 0 -X stuff `printf "stop\r"`
    echo "Stopping server [$NAME]"
    sleep 2
    screen -S $SCREEN -X quit
  else
    echo "Server [$NAME] is not running"
  fi
 ;;
*)
  echo "Usage: $0 {start|stop|status|reload|screen}"
 ;;
esac

exit 0
