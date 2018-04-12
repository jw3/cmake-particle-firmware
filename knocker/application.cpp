#include <application.h>

constexpr int Lhs = A0;
constexpr int Rhs = A1;

system_tick_t last = 0;
system_tick_t delays = 200;
int32_t threshold = 500;

void setup() {
   pinMode(Lhs, INPUT);
   pinMode(Rhs, INPUT);
}

void loop() {
   if(millis() - last > delays) {
      auto lhs = analogRead(Lhs);
      auto rhs = analogRead(Rhs);

      if(threshold < lhs && threshold < rhs) {
         Particle.publish("both", String::format("%d:%d", lhs, rhs), PRIVATE);
         last = millis();
      }
      else if(threshold < lhs) {
         Particle.publish("lhs", String(lhs), PRIVATE);
         last = millis();
      }
      else if(threshold < rhs) {
         Particle.publish("rhs", String(rhs), PRIVATE);
         last = millis();
      }
   }
}
