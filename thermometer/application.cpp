#include <OneWire.h>
#include <spark-dallas-temperature.h>

long last = 0;
int delays = 1;

OneWire oneWire(D4);
DallasTemperature sensors(&oneWire);

int sec2mill(int min);

void setup(void) {
   sensors.begin();
   Particle.publish("ready", PRIVATE);
}

void loop(void) {
   if(millis() - last > sec2mill(delays)) {
      sensors.requestTemperatures();
      String s(sensors.getTempFByIndex(0));
      Particle.publish("temp", s, PRIVATE);

      last = millis();
   }
}

int sec2mill(int min) {
   return 1000 * min;
}
