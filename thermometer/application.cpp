#include <OneWire.h>
#include <spark-dallas-temperature.h>

long last = 0;
int delays = 1;

OneWire oneWire(D0);
DallasTemperature sensors(&oneWire);

int min2mill(int min);

void setup(void) {
   sensors.begin();
   Particle.publish("ready", PRIVATE);
}

void loop(void) {
   if(millis() - last > min2mill(delays)) {
      sensors.requestTemperatures();
      String s(sensors.getTempCByIndex(0));
      Particle.publish("temp", s, PRIVATE);

      last = millis();
   }
}

int min2mill(int min) {
   return 1000 * 60 * min;
}
