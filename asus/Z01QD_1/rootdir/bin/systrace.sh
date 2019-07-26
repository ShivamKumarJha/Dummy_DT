atrace --async_start -z -b 20000 -t 5 gfx input audio view webview wm am hal app res dalvik rs bionic  sched freq  load sync workq memreclaim 
sleep 5
atrace --async_dump -z -b 20000 gfx input audio view webview wm am hal app res dalvik rs bionic  sched freq  load sync workq memreclaim  >/sdcard/atrace.out
