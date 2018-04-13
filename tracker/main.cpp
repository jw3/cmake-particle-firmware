#include <application.h>
#include <TinyGPS++.h>

long last = 0;
int delays = 1;

TinyGPSPlus gps;

int min2mill(int min);

void setup() {
   Serial1.begin(9600);
   Particle.publish("ready", PRIVATE);
}

void loop() {
   if(Serial1.available()) {
      auto str = Serial1.readStringUntil('\n');
      for(int i = 0; i < str.length(); ++i)
         gps << str.charAt(i);
   }

   if(millis() - last > min2mill(delays)) {
      auto location = gps.location;
      if(location.isValid() && location.isUpdated()) {
         auto lat = String(location.lat(), 6);
         auto lon = String(location.lng(), 6);
         auto str = String::format("%s:%s", lat.c_str(), lon.c_str());

         Particle.publish("pos", str, PRIVATE);
      }
      last = millis();
   }
}

int min2mill(int min) {
   return 1000 * 60 * min;
}
